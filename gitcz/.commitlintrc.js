// .commitlintrc.js
/** @type {import('cz-git').UserConfig} */
module.exports = {
  rules: {
    // @see: https://commitlint.js.org/#/reference-rules
  },
  prompt: {
    alias: { fd: 'docs: fix typos' },
    messages: {
      type: '選擇你要提交的類型:',
      scope: '選擇一個你要提交的範圍（可選）:',
      customScope: '請輸入自定義的提交範圍 :',
      subject: '填寫簡短精練的變更描述 :\n',
      body: '填寫更加詳細的變更描述（可選）。使用 "|"換行 :\n',
      breaking: '列舉非兼容性重大的變更（可選）。使用 "|"換行 :\n',
      footerPrefixesSelect: '選擇關聯Issue前綴（可選）:',
      customFooterPrefix: '輸入自定義Issue前綴 :',
      footer: '列舉關聯Issue（可選）例如: #31, #I3244 :\n',
      confirmCommit: '是否提交或修改commit？'
    },
    types: [
      { value: 'feat', name: 'feat:    🆕 新增功能 | A new feature' },
      { value: 'fix', name: 'fix:      🐛 修復bug  | A bug fix' },
      { value: 'docs', name: 'docs:    文件更新 | Documentation only changes' },
      { value: 'style', name: 'style:    程式風格 | Changes that do not affect the meaning of the code' },
      { value: 'refactor', name: 'refactor: 重構 | A code change that neither fixes a bug nor adds a feature' },
      { value: 'perf', name: 'perf:     性能優化 | A code change that improves performance' },
      { value: 'test', name: 'test:     測試相關 | Adding missing tests or correcting existing tests' },
      { value: 'build', name: 'build:    建構相關 | Changes that affect the build system or external dependencies' },
      { value: 'ci', name: 'ci:       持續集成 | Changes to our CI configuration files and scripts' },
      { value: 'revert', name: 'revert:   回退 | Revert to a commit' },
      { value: 'chore', name: 'chore:    其他修改 | Other changes that do not modify src or test files' },
    ],
    useEmoji: true,
    emojiAlign: 'center',
    useAI: false,
    aiNumber: 1,
    themeColorCode: '',
    scopes: [],
    allowCustomScopes: true,
    allowEmptyScopes: true,
    customScopesAlign: 'bottom',
    customScopesAlias: 'custom',
    emptyScopesAlias: 'empty',
    upperCaseSubject: false,
    markBreakingChangeMode: false,
    allowBreakingChanges: ['feat', 'fix'],
    breaklineNumber: 100,
    breaklineChar: '|',
    skipQuestions: [],
    issuePrefixes: [
      // 如果使用 gitee 作为开发管理
      { value: 'link', name: 'link:     連結 ISSUES 進行中' },
      { value: 'closed', name: 'closed:   標記 ISSUES 已完成' }
    ],
    customIssuePrefixAlign: 'top',
    emptyIssuePrefixAlias: 'skip',
    customIssuePrefixAlias: 'custom',
    allowCustomIssuePrefix: true,
    allowEmptyIssuePrefix: true,
    confirmColorize: true,
    maxHeaderLength: Infinity,
    maxSubjectLength: Infinity,
    minSubjectLength: 0,
    scopeOverrides: undefined,
    defaultBody: '',
    defaultIssues: '',
    defaultScope: '',
    defaultSubject: ''
  }
}

