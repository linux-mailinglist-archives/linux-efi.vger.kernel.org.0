Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9581E27D8
	for <lists+linux-efi@lfdr.de>; Tue, 26 May 2020 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgEZRC3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 26 May 2020 13:02:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40762 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEZRC3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 26 May 2020 13:02:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id c185so7220611qke.7
        for <linux-efi@vger.kernel.org>; Tue, 26 May 2020 10:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0HXWMhpIgTmqNl6PDghzhtC0QLa3pCcs/FQlrU8e6k=;
        b=CxaDigOIJKVMG/kv+VhP729Z7fXA6EE50HIsQlInP6xpQnDnug5WLpsV8YnH6nOaaW
         jLcesateLj1Yq3Erfrqu1UrSjiQvARAqq9oqVdEro7TAXKr14eLKmbFV6bwxc0+RBDt0
         IQ8IwVUcEH9zagMHDWdxPYu9nu1IDaGBgdTz0kkvBqIGlJ8M67WpA7liUpnEgexYYOGD
         OkTDVbrXYdq10zidQFgICgKH1aXCrDzxjTHrWT+8E1NcDqIsRHblRxt9ueMVe9UDBTKP
         Q7h08It5tirxmvc9U2o/rGPI64wJ6z3XX4hiq3cy2xbpNXMsQf4Taghq/i9V6Ht87lG+
         df4g==
X-Gm-Message-State: AOAM531/aBtrLceGkq/Wqdrc0GaiOg/LSAkW01uKMYOEgVFtmZ+Fg3Lu
        oWi16KwMbs/aC2/3f2Sf++LVGNgf
X-Google-Smtp-Source: ABdhPJy/fjeqLKXKSnmMJe5WOtL/iLh8a8t7zJtZkvlgJ12qpBjJc3dzF6sqa5p79vFEFB+iF73/Hg==
X-Received: by 2002:a37:b50:: with SMTP id 77mr2377701qkl.152.1590512548286;
        Tue, 26 May 2020 10:02:28 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l184sm125392qkf.84.2020.05.26.10.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:02:27 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 0/1] efi/x86: Use firmware stack for mixed-mode EFI stub
Date:   Tue, 26 May 2020 13:02:25 -0400
Message-Id: <20200526170226.2371024-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This patch is on top of the series removing runtime relocs [1].

[1] https://lore.kernel.org/lkml/20200525225918.1624470-1-nivedita@alum.mit.edu/

Arvind Sankar (1):
  efi/x86: Use firmware stack for mixed-mode EFI stub

 arch/x86/boot/compressed/head_64.S | 46 ++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 15 deletions(-)

-- 
2.26.2

