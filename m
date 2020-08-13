Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE40243F14
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 20:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMS6P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Aug 2020 14:58:15 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36157 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHMS6O (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Aug 2020 14:58:14 -0400
Received: by mail-qt1-f194.google.com with SMTP id t23so5198599qto.3;
        Thu, 13 Aug 2020 11:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0q3h4FnF2RC6T414mC+my3MOjYepZBJcgOxm130Jlyw=;
        b=GTRFuZVwKk3A5hZ/QKK8V1PDGTaMzo8ww2pg1dDVLI11y2PFKKnigWBi1VPrhvO4wg
         ftVKUuW8fkuHQ7XOAcnMe1uInEtpGJyXgXn4ThgSzSLTcgvFsNhtZbhQBOb/BBTWwAIo
         8HVtxWIypXjpcpWsOUidFZAfQLypnl8t/Dogj4tIhCJlvFvjuftBYR2yO8KRfdHW08RF
         EqI19wLuXM8zBRvbM0Yqjli8mAF5/0o/3fRqx/f2tmQeCnFEPrjdC+vW++yY0bxQ/pVd
         idMZ8Q8SQUDDKsC33jJZK700+fYLZDe0KoZ4dbLZXgLiKYM0KqwWvBy23oVK722YeZfQ
         umOQ==
X-Gm-Message-State: AOAM533ozMozGA5YFMI+v8L1ZiHNQpH11LLLzqJgcRxeUoJyNZJyy90q
        PSavTHC4VzUCtBIMcF7CL7A=
X-Google-Smtp-Source: ABdhPJzP5fxOtzw2g+vN0oAwM7Y5ZqerxhEVMvQL/p3WECh/bp6faRUp1kTnlT43Cjl0GKzBzRjWIA==
X-Received: by 2002:ac8:7152:: with SMTP id h18mr6674265qtp.44.1597345092079;
        Thu, 13 Aug 2020 11:58:12 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c9sm5994563qkm.44.2020.08.13.11.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 11:58:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Three small fixes to cmdline parsing
Date:   Thu, 13 Aug 2020 14:58:08 -0400
Message-Id: <20200813185811.554051-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

First 2 are resends:
https://lore.kernel.org/linux-efi/20200725155916.1376773-1-nivedita@alum.mit.edu/
https://lore.kernel.org/linux-efi/20200729193300.598448-1-nivedita@alum.mit.edu/

Arvind Sankar (3):
  efi/libstub: Stop parsing arguments at "--"
  efi/libstub: Handle NULL cmdline
  efi/libstub: Handle unterminated cmdline

 drivers/firmware/efi/libstub/efi-stub-helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.26.2

