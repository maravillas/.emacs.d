(require 'ag)

(setq ag-higlight-search t)

;; Workaround for issue where the edits in `wgrep' mode always resulted in
;; (No changes to be performed)
;; https://github.com/Wilfred/ag.el/issues/119
;; Sticking with the grouped results, but leaving this here for posterity.
;;(setq ag-group-matches nil)

(provide 'setup-ag)

