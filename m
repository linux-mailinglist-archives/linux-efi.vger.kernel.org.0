Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B913614E385
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3UEo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:44 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38864 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UEn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:43 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so3524358qtp.5;
        Thu, 30 Jan 2020 12:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BezU1G2xUPfm6IRf4eFTabgfYhZJiQDUc5pMPiqSZ0Y=;
        b=CU7QcmdixMbJ5QZ2xxO5el2JTfv39L7uDWnDpmEUCBffelJ3kdNHxVOrOQjJBmEA96
         3QOsOg3hKJMSkqw/PyEBIazjrOqGAuTcl42obhD1idF8Z857IOfqHKYxn3UpJkXeKs6c
         Bs/vn5s0B+JpJeYpDhlXEzpfHEmdTMO99LN/bq8pESXdKP7qK2hIu7aYAk9RvyISIlIZ
         3tBE3AUSsZ2ARsVl0GWey8Pnd3vVy8TPBI/31j9by5mhJh01I72C4i09BZXeg51e53UO
         5k8ohrQbRlhQUrxGtX6rFSyi+2jB9KECUY3Q0eZgdgXQbhYfUcySg8MPjhcW/2tcfHM5
         EMqA==
X-Gm-Message-State: APjAAAWXsa0kMLBogebAsMqe0XL13XzQBzKxuOber7w9U5k56K4rbmML
        jrbktEN9BLPI6DIsdwlFNvs=
X-Google-Smtp-Source: APXvYqz5DzVhX97FEH/3e1Pj03bRPjdqsDe23GUCYRy5xMFLXEO34uLuIrHvb7jsYIfE6gqI6M/mGA==
X-Received: by 2002:aed:218f:: with SMTP id l15mr6730278qtc.247.1580414682591;
        Thu, 30 Jan 2020 12:04:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:41 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/8] Remove 64-bit GDT setup in efi_main + doc fixes
Date:   Thu, 30 Jan 2020 15:04:32 -0500
Message-Id: <20200130200440.1796058-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For the 64-bit kernel, we do not need to setup a GDT in efi_main, as the
next step in the boot, startup_64, will set one up.

This series factors out the GDT setup into a separate function and
restricts it to the 32-bit kernel. The memory allocation for the GDT is
also changed from allocating a full page via efi_alloc_low to the
required space (32 bytes) from alloc_pool boot service.

The final two patches are doc fixes to clarify that the 32-bit EFI
handover entry point also requires segments/GDT to be setup, and that
for 64-bit mode we don't have any special segment requirements (the
64-bit doc currently is just a copy of the 32-bit doc which isn't
right).

Arvind Sankar (8):
  efi/x86: Use C wrapper instead of inline assembly
  efi/x86: Allocate the GDT pointer on the stack
  efi/x86: Factor GDT setup code into a function
  efi/x86: Only setup the GDT for 32-bit kernel
  efi/x86: Allocate only the required 32 bytes for the GDT
  efi/x86: Change __KERNEL_{CS,DS} to __BOOT_{CS,DS}
  Documentation/x86/boot: Clarify segment requirements for EFI handover
  Documentation/x86/boot: Correct segment requirements for 64-bit boot

 Documentation/x86/boot.rst              |  15 +-
 arch/x86/boot/compressed/eboot.c        | 174 ++++++++++--------------
 arch/x86/boot/compressed/efi_thunk_64.S |   4 +-
 3 files changed, 85 insertions(+), 108 deletions(-)

-- 
2.24.1

