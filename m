Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D05613282C
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgAGNzC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 08:55:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33701 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNzC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 08:55:02 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so45353354qto.0
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 05:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3w/reoK/2oUoEeJBkDSltH9y+LZu87+umFsGRF7mX7Q=;
        b=CIZLfeLvAIg1fpXuoUxcjc6pVKX89Rf4T2197DU7nrQr/bUMYTH5JaECHYIEML1SA7
         PgLZ6WWTAzy5sJFNPtFKqnqoCQ6Dyrp0obVC7DIqOnT0JrvWUjtHTRyZRoIgQXi7L8y/
         nvghsLWUOl9EhnfRAKEQTHaHGue44Nnqeh3kuToA+Xm4YaqjTWso46tzUF9HKKr6OEVy
         MrNrjFuShsjrI7+o69HDfjrQ4X8cBq4tpkL9IhJQ+kWdr2D5BXClzKQ2sz0XgAWF2UQZ
         LQc6EJcyCajvXxU5ly/w+Cs4NBTAYeN0Ohg3GDQ+VYzybP2dO1vgznX0PT6MtUYv1Gcm
         TWTQ==
X-Gm-Message-State: APjAAAVxeptNuvP7ilo2Ta5DPHeLKZdK5fdtn0I+Up4njDYVL/L6Y1Bt
        6USsOT70FwPPtxQoimR7vAK+4ofQ
X-Google-Smtp-Source: APXvYqyPvSu+Af3qQ1uE6j55CFejZ8vpWVnR7cn6lnrHo/ConysNHmwQLOXBI3/wn3ujr7XO+xLICA==
X-Received: by 2002:aed:238f:: with SMTP id j15mr80513524qtc.240.1578405301694;
        Tue, 07 Jan 2020 05:55:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v24sm25080627qtq.14.2020.01.07.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:55:01 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 0/3] Relocate GOT before calling EFI stub
Date:   Tue,  7 Jan 2020 08:54:57 -0500
Message-Id: <20200107135500.644618-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series performs GOT relocation before calling into C code for the
EFI stub. While the stub does not currently require GOT relocation, it's
quite easy to introduce code that will use the GOT on old toolchains,
but not recent ones, which can lead to unexpected issues.

This is based on
https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next

with commit 4169bb99cd70 ("efi/libstub/x86: use mandatory 16-byte stack
alignment in mixed mode") reverted, as it caused a crash in mixed mode.

Arvind Sankar (3):
  x86/boot/compressed/64: Make adjust_got easier to use repeatedly
  x86/boot/compressed/32: Allow adjust_got to be called repeatedly
  x86/boot: Perform GOT relocation before calling EFI stub

 arch/x86/boot/compressed/eboot.c   |  4 +-
 arch/x86/boot/compressed/head_32.S | 65 +++++++++++++++++++++----
 arch/x86/boot/compressed/head_64.S | 76 +++++++++++++++++-------------
 3 files changed, 99 insertions(+), 46 deletions(-)

-- 
2.24.1

