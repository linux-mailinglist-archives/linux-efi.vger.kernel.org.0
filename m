Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F89A1750BA
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCAXEi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:04:38 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46157 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgCAXEi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:04:38 -0500
Received: by mail-qv1-f65.google.com with SMTP id bo12so4012869qvb.13;
        Sun, 01 Mar 2020 15:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nd3eQk6IJUsxjoRR9Bi713Kh3T/i2L+8XYZcLUtHK7g=;
        b=KJuNUUMZWnyBrzt2G9grn1pd2796XpCoeGkiyiVZ8L43SCQLnMRZn6VDXqjd18WRBA
         wj1f+WTIzr+SNVWmk4GYT70Tm7B9/43/14dkbxlwEI17pBqqILZJAcrKaCLxgnYb6Jjv
         lScNlqtSvo+4iTqo0E7zzHoE/jkPg4FTSKcyoiSV9Ms6L3KunYwzJXgpo4KhM3u4l0sT
         rXSPd8OK01M03dlzL+OOmb6cy4K+Kh9ZaFS54vwnkQ4GJ1YJAOvA9TvihKSws9clXyAU
         IMkBzhW+s7tc8J9mA+yBWYCVvQlwf/RTHIdoZykXD5GD4cociLje46Z0w8zqEiT+JVP/
         PAsA==
X-Gm-Message-State: ANhLgQ0v+V2VyN7++MbRaIWb2KoyAFFPOb2As55Y94ef7MjrR0BT+DFK
        2Hpa6BDVALVce7DvUpxmLUwQ/mbqI9s=
X-Google-Smtp-Source: ADFU+vu8SYw278CFduTvE2z+5Cvc3eDoUj5VC1q3edIrCgtBEuOVoEXRLwWsW8H3i6g5Zi/KPW65WA==
X-Received: by 2002:a0c:e804:: with SMTP id y4mr2641584qvn.243.1583103877482;
        Sun, 01 Mar 2020 15:04:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n138sm9065082qkn.33.2020.03.01.15.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:04:37 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] efi/x86 cleanups and one bugfix
Date:   Sun,  1 Mar 2020 18:04:31 -0500
Message-Id: <20200301230436.2246909-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

First 3 patches are misc. beautifications to the new compat PE entry
code.

Next patch stops EFI stub using code32_start field to communicate the
address of startup_32, instead returning it directly to efi_stub_entry.

Last patch is a bugfix for x86/boot/head code to use unsigned
comparisons on addresses rather than signed.

Based on tip:efi/core

Arvind Sankar (5):
  efi/x86: Annotate the LOADED_IMAGE_PROTOCOL_GUID with SYM_DATA
  efi/x86: Respect 32-bit ABI in efi32_pe_entry
  efi/x86: Make efi32_pe_entry more readable
  efi/x86: Avoid using code32_start
  x86/boot: Use unsigned comparison for addresses

 arch/x86/boot/compressed/head_32.S      |  5 +-
 arch/x86/boot/compressed/head_64.S      | 70 ++++++++++++++++++-------
 arch/x86/kernel/asm-offsets.c           |  1 -
 drivers/firmware/efi/libstub/x86-stub.c | 10 ++--
 4 files changed, 57 insertions(+), 29 deletions(-)

-- 
2.24.1

