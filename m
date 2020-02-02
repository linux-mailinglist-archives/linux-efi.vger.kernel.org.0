Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4381514FE73
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgBBRN4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:13:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37996 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgBBRN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:13:56 -0500
Received: by mail-qk1-f195.google.com with SMTP id k6so11929958qki.5;
        Sun, 02 Feb 2020 09:13:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkB9hEzJnTGg0+titOdjnKOkA5bK07ut9KDYjyipcyQ=;
        b=XLwYkWNir2DWBtBW7uyPEqO1le1ovip+CWBmdvJivK6P7lopltFO/ZaaQmsxG8soLD
         cgt6MVmvjH3TEFy7IjJryoYQuEHBo3tROOXlQXwnZPuyWBjUrKgZLWusKy0WjxIkEauJ
         GXx/0k22r9lnLa4QYBamM0RDElfr3mGnHJ8uocI6UoXoSTEsIWqxzEXxvLPTUBvcZx/I
         xQ4n3pZB6tNZQ3W02tKHev4PTfqNACYF7xcG+P/D7/f2nLCoCa6AMO1M+ioxVFzUQ0gO
         /SBcZNPxE6sDeL/0olMZtQY1VE3Wj1w9f5scUEkS4sOSB4SvfCEpCj5OM8KaG5QsqLoy
         2MEg==
X-Gm-Message-State: APjAAAXs2k/33ouLDQMC9dlOdaJJDQ9Daiz106Lcj1txE61RKZEJ+MM1
        79db2ldW8qbITXniJN0sSgk=
X-Google-Smtp-Source: APXvYqy6GSEPqc154do67Yx2BRzju/BO1xu6ATlNJHsqHsL2qBR8epiNbj/7XivSIA4CxHRVd7RRow==
X-Received: by 2002:a37:be07:: with SMTP id o7mr5554219qkf.392.1580663634734;
        Sun, 02 Feb 2020 09:13:54 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:54 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] x86/efi,boot: GDT handling cleanup/fixes
Date:   Sun,  2 Feb 2020 12:13:46 -0500
Message-Id: <20200202171353.3736319-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This series fixes a potential bug in EFI mixed-mode and leaves GDT
handling to startup_{32,64} instead of efi_main.

The first patch removes KEEP_SEGMENTS support in loadflags, this is
unused now (details in patch 1 commit msg), to slightly simplify
subsequent changes.

The second patch fixes a potential bug in EFI mixed-mode, where we are
currently relying on the firmware GDT having a particular layout: a
CODE32 segment as descriptor 2 and a DATA segment as descriptor 3.

The third patch adds some safety during kernel decompression by updating
the GDTR to point to the copied GDT, rather than the old one which may
have been overwritten.

The fourth patch adds cld/cli to startup_64, and the fifth patch removes
all the GDT setup from efi_main and adds it to the 32-bit kernel's
startup_32. The 64-bit kernel already does GDT setup. This should be
safer as this code can keep track of where the .data section is moving
and ensure that GDTR is pointing to a clean copy of the GDT.

The last two patches are to fix an off-by-one in the GDT limit and do a
micro-optimization to the GDT loading instructions.

Changes from v1:
- added removal of KEEP_SEGMENTS
- added the mixed-mode fix
- completely removed GDT setup from efi_main, including for the 32-bit
  kernel
- dropped documentation patches for now

Arvind Sankar (7):
  x86/boot: Remove KEEP_SEGMENTS support
  efi/x86: Don't depend on firmware GDT layout
  x86/boot: Reload GDTR after copying to the end of the buffer
  x86/boot: Clear direction and interrupt flags in startup_64
  efi/x86: Remove GDT setup from efi_main
  x86/boot: GDT limit value should be size - 1
  x86/boot: Micro-optimize GDT loading instructions

 Documentation/x86/boot.rst              |   8 +-
 arch/x86/boot/compressed/eboot.c        | 103 ------------------------
 arch/x86/boot/compressed/efi_thunk_64.S |  29 +++++--
 arch/x86/boot/compressed/head_32.S      |  48 +++++++----
 arch/x86/boot/compressed/head_64.S      |  66 ++++++++-------
 arch/x86/kernel/head_32.S               |   6 --
 6 files changed, 99 insertions(+), 161 deletions(-)

-- 
2.24.1

