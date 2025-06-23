Return-Path: <linux-efi+bounces-3902-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1347AE3826
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64ED07A334B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163B220F50;
	Mon, 23 Jun 2025 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/+hI6sB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6821FF58;
	Mon, 23 Jun 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750666557; cv=none; b=u0AZaorlJ8Ll6kCs2TVPYujGlPaBgsTP/tuUjX30WPaUKEWnDTETY7dE5laPAJqVQWV8VMtG+o1G+RqxWkL+O3l3Q98xHlCE/XMNj6/XPKSbgF+hlRBypyW/pYXKddaVQ3/oT+L4yNYPsi5t8/uZHOtOubJqs19WBk7+8ql+kZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750666557; c=relaxed/simple;
	bh=k5zDKD0LjcERNL0AeTUME0SOFSz+osO+4vT9kb2i2aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OzvDOU08m3vhZMSlBPyKsH5VvBnvlRFgpn1qiqVU+3TbkPMMcnDOrLb+Wix6lYD1hQ2TCBgiI7C/3GIYteuwVooQcckVc7aSxSJAUGzfFWNdjiuIXWStS0qh4OBycyhaqEEHEThdqmd2RYrqahHRJE5Rz+PpLeGuqHMtVf0Qc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/+hI6sB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade326e366dso709858866b.3;
        Mon, 23 Jun 2025 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750666554; x=1751271354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LebPancsy/yb4J4BSpIRry/vVuAHPGWmDXym1wDvZ88=;
        b=K/+hI6sBK2dc+2jLngK/iTk7f9WCAvMxtCbAjXs0xkhQy4m29SbgaqaIo3xddL6nDz
         lhkii487+hkMEyhP8Aqf+WBXacYK6KffSv0o00olRkL2tIKiBgoQ0G7/z1mRIZ0YvNUD
         VvAPUZeW6TUfV3xae2olvYIrhwVGc1VPfiDaDXVWJ9bu1Fmx4g9dIj3JEXaeWCSAjov/
         aM+csl16U/MI+4IsywcJU/QA5B3eqYHP4JwMxKJTY2PtEkHe3l0MhhRjZMGVAamCArMp
         /4woJ9nnShWGNBlhXNWFgzUUNvhryI6ePTXI6Fc+MTLIOb3kXYPg/6Yhq6rJlnT2R/Y3
         flnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750666554; x=1751271354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LebPancsy/yb4J4BSpIRry/vVuAHPGWmDXym1wDvZ88=;
        b=ktVoeFdgMLorbZH596MbZMvHqtyjgrmGBwrJC5iBlqMVBQZJX+C2ONLD57EV8cOshh
         4eKxBRYujWt1xC/OJItAdU0JDbK+goMBZg56nsKFf0DpOY976inO9ytkpLCMmGkB/emG
         Pi1RM6FuOuE4bVNrE8NUoFZEhvAda9AM3O9XkV89ysdKeLl5U41J3ahYR7UL+5w8G55g
         +X+Fxa4o54B8U7UAc1ssh2grqWbSDBx91KD8pOakiPB9TfrYsOuWJ/a3q3CK/KB2O86l
         viAGFHVNecz9fdgXVis0hFCOYrEaHkjUmkZ9zTOOhrFId9/eDlTJ4CKu91wJu8gf8kc/
         T9ng==
X-Forwarded-Encrypted: i=1; AJvYcCVeIwp7+Zh9LFXzisQzfhRD39JGuIci4gHf+Z34SBJTpjLhO82Rs6I5wjmi5DXZxlr1q5RRm8XP9oY=@vger.kernel.org, AJvYcCWaVhdLJLFar2PGACyXFeBvHWFpFwa5qOtG6wkgq7iqYyAmPI4wMEFytpYQ7uEZkMM1qeUGGJzl9n/Yirqt@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmvHUXDu53pkHUpPdkQaCGVjVRAKnE07MxeCxQIf33T7+o+NS
	LhagytkJJNrVipoCB3kNQXD8i0zoPaD4gSiNGWkUEyrkuJAuez5h7Y/f
X-Gm-Gg: ASbGnctg/tyAh811xHWTalTO2HUt0yBk5RZJr9B42uixgtmnXIGElFIT4JyTSMQrmAX
	9TFsiBlfZPG3UIU7yn6x5ALMpPtPwV2ffdMpr5e0ISgf39HLGgohfofOsUEJxu2oZeIWMp0He22
	ZH4gnAu2T4LAvZR0dxU0U5OHsH97SGi5Cr7EYlFrpCvbB2SPmEi+yKhgpuPzh6ORF40svrKKZfO
	5y868l94KeU+y5RBXlLOZXuim/t/XwMoYt4ESAeSpdAom5M+xu3EfzN207zlrNJ02PQ0TWIbeDv
	w030RIvhWXhOsCtjF8FlVZdrCveedl0Eg62mqujOd1wqKoiKgJMBPCP12xir/DXi+1qPah65wa2
	Z
X-Google-Smtp-Source: AGHT+IGhMhHuysrmmewYTNPppMUFuwYZEZPLMMSfrG/qfa7QUb+8IWiWHfNfmKFchqJOiQFwm/zMKQ==
X-Received: by 2002:a17:907:6088:b0:ade:36e4:ceba with SMTP id a640c23a62f3a-ae057f3c214mr1106054966b.52.1750666553810;
        Mon, 23 Jun 2025 01:15:53 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6f74sm666970466b.114.2025.06.23.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 01:15:53 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khalid Ali <khaliidcaliy@gmail.com>
Subject: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi from startup_64()
Date: Mon, 23 Jun 2025 08:14:55 +0000
Message-ID: <20250623081458.1243-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Khalid Ali <khaliidcaliy@gmail.com>

The current kernel entry point takes one argument which is boot_param
from RSI. The only argument entry point recieves is pointer to
boot_param.

In order to comply with the ABI calling convension the entry point must
recieve the boot_param from RDI instead of RSI. There were no specific
use case used for RDI, so the kernel can safely recieve argument from
that register to better comply with ABI.

This patch makes the kernel to recieve boot_param which is the only
argument it recieves, from RDI instead of RSI. All changes needed for
stability and clarity have being changed.

Changelog:
 * Kernel uncompressed entry point expects boot_param from RDI instead
   of RSI.
 * The decompressor has being adjusted to supply argument from RDI
   instead RSI.
 * libstub has being adjusted to supply argument from RDI instead of RSI.

After throughly tested there were no regression and UDs has being
observed. Looking forward for feedback.

 arch/x86/boot/compressed/head_64.S      | 2 +-
 arch/x86/kernel/head_64.S               | 4 ++--
 drivers/firmware/efi/libstub/x86-stub.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.49.0


