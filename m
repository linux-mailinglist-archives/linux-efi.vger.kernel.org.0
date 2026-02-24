Return-Path: <linux-efi+bounces-6218-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGhqHjiLnWnBQQQAu9opvQ
	(envelope-from <linux-efi+bounces-6218-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 12:27:52 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C518642E
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 12:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D729300E4BC
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132FA37C106;
	Tue, 24 Feb 2026 11:24:09 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830937C101;
	Tue, 24 Feb 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932249; cv=none; b=tvsvhi9wZfQhQ/V+Fw4Gs0DvIrD/Ln8LNQmDZqE0FHylB4T2sBoxQ56v9kZwEF0j6u2KyK35cRmZAbuWNcKrYtgTOuDREAiA/lLd3oJ4qxDhjI86EvNpUTv1oQYQmzKWhIc2q5stas5Z5bdc7MkxpP8he7bla1jhSRlE/bqqkl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932249; c=relaxed/simple;
	bh=kVx/H6oRjNOdFfka1DfIJ9iHFi9JXILBcKcsrEOFPh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tL4ITQhzn4N6vVjubEJYum/uzBCSkZGNaz0COJEjgYJmB0aWxu7babZh2aZQIMw/qrk/sj8UhDx1JX0e0EQ0NgmIpD73i7KIWX0N0tfq2l5QmIUgzRQGBsli8pp4rMVXQbCMLOF82czaYfj27+aglTR9IWXnweXhAJReg2WwdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fKwMX1yB6zJ46sr;
	Tue, 24 Feb 2026 19:23:36 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BB87940539;
	Tue, 24 Feb 2026 19:23:57 +0800 (CST)
Received: from dubpeml500008.china.huawei.com (7.214.146.94) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Feb 2026 11:23:57 +0000
Received: from dubpeml500008.china.huawei.com ([7.214.146.94]) by
 dubpeml500008.china.huawei.com ([7.214.146.94]) with mapi id 15.02.1544.011;
 Tue, 24 Feb 2026 11:23:57 +0000
From: Shiju Jose <shiju.jose@huawei.com>
To: Kai-Heng Feng <kaihengf@nvidia.com>, "ardb@kernel.org" <ardb@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, "Guohanjun (Hanjun Guo)"
	<guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Morduan Zang <zhangdandan@uniontech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] efi/cper: Add NVIDIA CPER section support
Thread-Topic: [PATCH] efi/cper: Add NVIDIA CPER section support
Thread-Index: AQHcpJCy3fIFpd0GQEKD/TgSJF+VC7WRsUUw
Date: Tue, 24 Feb 2026 11:23:57 +0000
Message-ID: <786211585e2b4a1fbca58c1427102260@huawei.com>
References: <20260223064924.6449-1-kaihengf@nvidia.com>
In-Reply-To: <20260223064924.6449-1-kaihengf@nvidia.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6218-lists,linux-efi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-efi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shiju.jose@huawei.com,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 871C518642E
X-Rspamd-Action: no action

>-----Original Message-----
>From: Kai-Heng Feng <kaihengf@nvidia.com>
>Sent: 23 February 2026 06:49
>To: ardb@kernel.org
>Cc: Kai-Heng Feng <kaihengf@nvidia.com>; Rafael J. Wysocki
><rafael@kernel.org>; Tony Luck <tony.luck@intel.com>; Borislav Petkov
><bp@alien8.de>; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>; Mauro
>Carvalho Chehab <mchehab@kernel.org>; Shuai Xue
><xueshuai@linux.alibaba.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; Morduan Zang
><zhangdandan@uniontech.com>; linux-kernel@vger.kernel.org; linux-
>efi@vger.kernel.org; linux-acpi@vger.kernel.org
>Subject: [PATCH] efi/cper: Add NVIDIA CPER section support
>
>Add support for decoding NVIDIA-specific error sections in UEFI CPER recor=
ds.
>NVIDIA hardware generates vendor-specific CPER sections containing error
>signatures and diagnostic register dumps. This implementation decodes thes=
e
>sections and prints error details to the kernel log.
>
>The NVIDIA CPER section contains a fixed header with error metadata (signa=
ture,
>error type, severity, socket) followed by variable-length register address=
-value
>pairs for hardware diagnostics.
>
>This work is based on libcper [0].
>
>Example output:
>Hardware error from APEI Generic Hardware Error Source: 816 event severity=
:
>info  imprecise tstamp: 2025-11-17 07:57:38  Error 0, type: info
>  section_type: NVIDIA, error_data_length: 224
>  signature: HSS-IDLE
>  error_type: 0
>  error_instance: 0
>  severity: 0
>  socket: 255
>  number_regs: 12
>  instance_base: 0x0000000000000000
>  register[0]: address=3D0x0000000004f10008 value=3D0x0000000000002019
>  register[1]: address=3D0x0000000000000000 value=3D0x0000000000000000
>
>[0] https://github.com/openbmc/libcper/commit/683e055061ce
>Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
>---
> drivers/firmware/efi/Kconfig       | 16 ++++++
> drivers/firmware/efi/Makefile      |  1 +
> drivers/firmware/efi/cper-nvidia.c | 79 ++++++++++++++++++++++++++++++
>drivers/firmware/efi/cper-nvidia.h | 33 +++++++++++++
> drivers/firmware/efi/cper.c        |  3 ++
> include/linux/cper.h               |  4 ++
> 6 files changed, 136 insertions(+)
> create mode 100644 drivers/firmware/efi/cper-nvidia.c
> create mode 100644 drivers/firmware/efi/cper-nvidia.h
>
>diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig i=
ndex
>29e0729299f5..ed1f53b8e878 100644
>--- a/drivers/firmware/efi/Kconfig
>+++ b/drivers/firmware/efi/Kconfig
>@@ -329,6 +329,22 @@ config UEFI_CPER_X86
> 	depends on UEFI_CPER && X86
> 	default y
>
>+config UEFI_CPER_NVIDIA
>+	bool "UEFI CPER NVIDIA support"
>+	depends on UEFI_CPER
>+	help
>+	  This option enables support for decoding NVIDIA-specific error
>+	  sections in UEFI Common Platform Error Records (CPER). These
>+	  sections contain additional diagnostic information for errors
>+	  occurring in NVIDIA hardware such as GPUs, switches, and other
>+	  devices.
>+
>+	  The NVIDIA CPER sections include error signatures (e.g., PCIe-DPC,
>+	  DCC-ECC, GPU-STATUS) and diagnostic registers that provide detailed
>+	  information about hardware errors for debugging and analysis.
>+
>+	  If unsure, say N.
>+
> config TEE_STMM_EFI
> 	tristate "TEE-based EFI runtime variable service driver"
> 	depends on EFI && OPTEE
>diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile=
 index
>8efbcf699e4f..a571b6086860 100644
>--- a/drivers/firmware/efi/Makefile
>+++ b/drivers/firmware/efi/Makefile
>@@ -42,5 +42,6 @@ obj-$(CONFIG_EFI_CAPSULE_LOADER)	+=3D capsule-
>loader.o
> obj-$(CONFIG_EFI_EARLYCON)		+=3D earlycon.o
> obj-$(CONFIG_UEFI_CPER_ARM)		+=3D cper-arm.o
> obj-$(CONFIG_UEFI_CPER_X86)		+=3D cper-x86.o
>+obj-$(CONFIG_UEFI_CPER_NVIDIA)		+=3D cper-nvidia.o

Hi,

Is drivers/firmware/efi/cper.c the right place to log vendor-specific error=
s,=20
given that so far drivers/firmware/efi/ only logs CPER information defined =
by the standards?
Vendor-specific errors are currently logged and recorded in rasdaemon.
https://github.com/mchehab/rasdaemon
https://github.com/mchehab/rasdaemon/blob/master/ras-non-standard-handler.c=
#L52

If some kernel-level  recovery action or logging is required, we can also r=
egister with
acpi/apei/ghes using ghes_register_vendor_record_notifier() to receive a ca=
llback.
https://elixir.bootlin.com/linux/v6.19.3/source/drivers/acpi/apei/ghes.c#L6=
52

[...]
>+/* NVIDIA Error Section */
>+#define CPER_SEC_NVIDIA
>	\
>+	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec, 0xbe, 0xa7, 0xcb, 0x3f,	\
>+		  0xdb, 0x95, 0xc7, 0x86)
>
> #define CPER_PROC_VALID_TYPE			0x0001
> #define CPER_PROC_VALID_ISA			0x0002
>--
>2.43.0
>

Thanks,
Shiju

