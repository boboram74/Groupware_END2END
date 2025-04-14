package com.end2end.spring.util;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PageNaviUtil {
    private int page;
    private int totalLength;

    private int getStartNavi() {
        return (page - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
    }

    private boolean isFirst() {
        return getStartNavi() == 1;
    }

    private boolean isEnd() {
        return getEndNavi() == getPageCount();
    }

    private int getEndNavi() {
        int endNavi = getStartNavi() + (Statics.naaviCountPerPage - 1);
        return Math.min(endNavi, getPageCount());
    }

    private int getPageCount() {
        return (int) Math.ceil((double)totalLength / Statics.recordCountPerPage);
    }

    public PageNavi generate() {
        return new PageNavi(getStartNavi(), getEndNavi(), !isFirst(), !isEnd());
    }

    @Data
    public static class PageNavi {
        private int start;
        private int end;
        private boolean hasPrev;
        private boolean hasNext;

        private PageNavi(int start, int end, boolean hasPrev, boolean hasNext) {
            this.start = start;
            this.end = end;
            this.hasPrev = hasPrev;
            this.hasNext = hasNext;
        }
    }
}
