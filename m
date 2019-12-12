Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9084C11C953
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfLLJiY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 04:38:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44256 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfLLJiX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 04:38:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so1919235wrm.11;
        Thu, 12 Dec 2019 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PJeytsvwWl8WuLPzmu0cCUjnyOYJkNJeR/9gq40ppbo=;
        b=DMyWdFLAd0oSrDo/7o7GHv5/qmtTOadoKRpRyh9IpsxYB89dXMwRt0URuqKY6rxZgn
         pmOs9Io5xGpRe3EuVgIosLG2ZqInU/MhWczvBHKrUWV815EelswDFsQR4h5BDwhaZ2gQ
         4Ttjg3Nfi734kcgMcfTcnQTbQKXj42Fye0OR1gAQbIvvEU7YCyN6el+/5E7hiYUCmkmI
         q/9nKJ1Ps3/vBRT68uN8AER0s0oddiC2ID1twFgY830pqGtfEJNQ+JK/oz8mQJyR1K5P
         zAdXkONR+turs0PtjQ4qWVVuJNaktLDtkzTFfK6xFmdPUgQEuPbqGMVIldSfjwOANTEb
         eEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PJeytsvwWl8WuLPzmu0cCUjnyOYJkNJeR/9gq40ppbo=;
        b=dYBd9jx8Gr/ufn4KSLl1Y2UwXPViKTQziuKTxsJ7roVglDlI4W4gAnWF+WROfLP0aI
         TKg1yznx4x7ddN1sYdo092EvxVngbwMg0RDTny09EMhkR6IWz4ZwomMukPw61fmSrCLY
         5J8gwqAftjmzjUOBPHm/Qb8UFYXHhHhJLnBODSWRz5lVEOMQYTgilRwLujT+py5n+RKL
         IjuwjzguyV53dIPKTwYnkDcqaQzEwqTOypLOa5CPhPsSnlNbsRZ3b744yS2WOAlXUnWS
         O1BRg+nRmHRzfcJrlNdfk+A/fvTAqSGvNvd6F7bCK2DGteqId/kJzO3iEE+TU0cmq68v
         NpdA==
X-Gm-Message-State: APjAAAX0Nl4NJ168vsVmFUnzBWPhJ8hTtlz5M0JYS1Jm2ukk1VR4DTLU
        61wPoulz/w6mm34kNt17vcM=
X-Google-Smtp-Source: APXvYqxBft0ox471wo2hPqnx5cF4GFUbvKznwBqqUsy8EOeJGfouxM6c+SNTbbCaZxvK/amYUNZ+yA==
X-Received: by 2002:adf:f802:: with SMTP id s2mr5156241wrp.201.1576143501205;
        Thu, 12 Dec 2019 01:38:21 -0800 (PST)
Received: from linux-691t.suse.de ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id z8sm5471508wrq.22.2019.12.12.01.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 01:38:20 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH 0/2] efi: cosmetic patches for the error messages when loading certificates
Date:   Thu, 12 Dec 2019 17:38:10 +0800
Message-Id: <20191212093812.10518-1-jlee@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When loading certificates list from EFI variables, the error
message and efi status code always be emitted to dmesg. It looks
ugly:

[    2.335031] Couldn't get size: 0x800000000000000e
[    2.335032] Couldn't get UEFI MokListRT 
[    2.339985] Couldn't get size: 0x800000000000000e
[    2.339987] Couldn't get UEFI dbx list

This cosmetic patch set moved the above messages to the error
handling code path. And, it adds a function to transfer EFI status
code to string to improve the readability of debug log. The function
can also be used in other EFI log.

Lee, Chun-Yi (2):
  efi: add a function for transferring status to string
  efi: show error messages only when loading certificates is failed

 include/linux/efi.h                           | 26 +++++++++++++++++
 security/integrity/platform_certs/load_uefi.c | 41 ++++++++++++++-------------
 2 files changed, 48 insertions(+), 19 deletions(-)

-- 
2.16.4

