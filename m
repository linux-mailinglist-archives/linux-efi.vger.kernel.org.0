Return-Path: <linux-efi+bounces-946-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03438ACC04
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 13:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8205E2823EA
	for <lists+linux-efi@lfdr.de>; Mon, 22 Apr 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E621465B7;
	Mon, 22 Apr 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsgLicLO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301E146595
	for <linux-efi@vger.kernel.org>; Mon, 22 Apr 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713785265; cv=none; b=ZySX/OwZ16ljEu5BtTHB2aE56CfVfv8a4P04qVwpd7ZX9rBsTJC588CwHqDHtIbbAxv/TOSpbKRq+Ck5rb7yTwgmOuT18DPI7nRMcu4KVqtgeWauW+fV1NIJwCKCOiAnDnk75S5DZx8bhN3vA1ksAAw9jkpc7ispmZ8Lkn6mKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713785265; c=relaxed/simple;
	bh=IIERLXGuhgMzjRFxP+SlabqBW/eSZqSY7rrmn3OK2ZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXYQ2Bm0YQ6UHW8upzvxFBQHXy/a3rgZ+KkbzQmgpC0SGDpXHTb71j2xMniA7msTUvfJtn5bWgM7+VoCD/w1vLkOONpx+j6zbp8lbhw2BXt96jgugAcY+W1f8N0g0dd5hAnrgDe7XRtGibPJFylj7/XeULmXJTyqMkMzJcsvnHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YsgLicLO; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518931f8d23so4382906e87.3
        for <linux-efi@vger.kernel.org>; Mon, 22 Apr 2024 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713785261; x=1714390061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pAHS0Gv/aJRFLYbSUujnvPu8mogZARnmQtFNoH+oLlw=;
        b=YsgLicLOL5/+sMeZ4Fb93pDeW87OdAAKFP1sh+GAiaULlhULZPpwCaL1QP8w8v/S78
         up/oZ3xE55POrKqsRsMj/G5arH6MkXiK6daGL6UXW4YwXxOvZEiduKYyWke0MvNQXR4+
         Dp5noQD0VZorhFLtQNfSt3A8zRpNPw7vILnpBbJTyry2AsFRu/avEsKSA5aT+7Xg3VDe
         idYz275oYQMRXAd5W0J6YW3YZIEc3smamUurw+cgVEPxoMXGBRWakjw/Jki4aP03j4c6
         Yf4WApaLKHs8i5NhtPK0GzhvCksWXGNgr1vv+/NeKmbHL3XrCcJTYym5bHjl3OUCvcbe
         kwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713785261; x=1714390061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAHS0Gv/aJRFLYbSUujnvPu8mogZARnmQtFNoH+oLlw=;
        b=f74anykMFquB+HeAsvz4aPrC2zTgt56ON6rwfhey8AUR524SbbSZoU8uJ+7Ag/Frkk
         k5VPiDqaMjLmMMHrWbDTbgtWILAIsMp0VZvOwn4qgDDwHYjQQAg2ae1S+WCchPJ2kBdC
         /Eg8QqzPnn6ZNs3yEusdLPe8q1ZN/DaDN4fJNdH582eLGgf8hQRe/zjmx2KeHxoWyJ+j
         YEMckZ1YyVvmPZl7lcFDpGq06CdlZpcmZrl6GdfaBFnwYm4PS9Rl1CAH4RudD3AN83Z8
         advx9EbdEzfTZ6frZlxgIyzHJEnW/QBUgVWEBX69wOQ78VgWKnsp0JQn5BhJAi0gZ8jo
         29Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUFHz/EB35tzhwqoS5Bvsha0O76fcqA4faRXzZ1IwZyMTkuSCFkyv+Ky4I6DIesTcK5Nu1ESxTgzwTm4XQ/OLSkBKuokrIHrcVV
X-Gm-Message-State: AOJu0YxCNS31e1MPsIodtfJLWolRo77sdXBZ7CfBmOuUNZf8nU8K0qbM
	hh2gxU17pvYKEiJXGgUP9+8WcnNeu6SprHfWN9jqmniZ9vy7b5+FG3/YYZig1jk=
X-Google-Smtp-Source: AGHT+IE8EBr5NvmY11IDYuiTNid1hwFS7mppMFMZCTSBlKU5z9TbJJgtf22eemyN27XguoGl4AJ18g==
X-Received: by 2002:ac2:5963:0:b0:518:ddc3:b3a2 with SMTP id h3-20020ac25963000000b00518ddc3b3a2mr5172597lfp.28.1713785261086;
        Mon, 22 Apr 2024 04:27:41 -0700 (PDT)
Received: from localhost.localdomain (87-100-245-199.bb.dnainternet.fi. [87.100.245.199])
        by smtp.gmail.com with ESMTPSA id a15-20020ac25e6f000000b00517041af89dsm1738793lfr.293.2024.04.22.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 04:27:40 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lennart Poettering <lennart@poettering.net>
Subject: [PATCH] efi: expose TPM event log to userspace via sysfs
Date: Mon, 22 Apr 2024 14:27:11 +0300
Message-Id: <20240422112711.362779-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace needs to know if TPM kernel drivers need to be loaded
and related services started early in the boot if TPM device
is used and available. If EFI firmware has used TPM device
to e.g. measure binaries, then many of them also provide the TPM
log to kernel in addition to the actual TPM device side measurements.
Expose availability of TPM event log to userspace via
/sys/firmware/efi/tpm_log. If the file exists, then firmware
provided a TPM event log to kernel, and userspace init should also
queue TPM module loading and other early boot services for TPM support.

Enables systemd to support TPM drivers as modules when rootfs is
encrypted with the TPM device.

Sample output from a arm64 qemu machine with u-boot based EFI firmware
and swtpm:

root@trs-qemuarm64:~# dmesg|grep TPMEvent
[    0.000000] efi: TPMFinalLog=0xbd648040 RTPROP=0xbd646040 SMBIOS3.0=0xbe6ad000 TPMEventLog=0xbd5f9040 INITRD=0xbd5f7040 RNG=0xbd5f6040  MEMRESERVE=0xbd5f5040
root@trs-qemuarm64:~# ls -l /sys/firmware/efi/tpm_log
-r-------- 1 root root 4096 Apr 22 10:31 /sys/firmware/efi/tpm_log
root@trs-qemuarm64:~# cat /sys/firmware/efi/tpm_log
TPMEventLog=0xbd5f9040
root@trs-qemuarm64:~# cat /sys/firmware/efi/systab
SMBIOS3=0xbe6ad000

Other similar information is currently in /sys/firmware/efi/systab but
for new exported variables a one-variable-per-file sysfs interface
is preferred according to comments in systab_show()
drivers/firmware/efi/efi.c

See also:
https://github.com/systemd/systemd/pull/32314
https://lists.freedesktop.org/archives/systemd-devel/2024-April/050206.html

Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 Documentation/ABI/testing/sysfs-firmware-efi | 12 ++++++++++++
 drivers/firmware/efi/efi.c                   | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
index 5e4d0b27cdfe..caaff27cc73e 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -36,3 +36,15 @@ Description:	Displays the content of the Runtime Configuration Interface
 		Table version 2 on Dell EMC PowerEdge systems in binary format
 Users:		It is used by Dell EMC OpenManage Server Administrator tool to
 		populate BIOS setup page.
+
+What:		/sys/firmware/efi/tpm_log
+Date:		April 2024
+Contact:	Mikko Rapeli <mikko.rapeli@linaro.org>
+Description:	If EFI firmware supports TPM device and measurements were done
+		then a TPM event log has very likely been generated and provided
+		to the kernel. This serves as indicator for userspace to load
+		TPM drivers and to start related service early in the boot sequence,
+		e.g. initramfs, where full bus probes and device scans are not yet
+		done.
+Users:		systemd will use this interface to support TPM drivers as modules also
+		for early initramfs
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4fcda50acfa4..94773e8b8806 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -162,6 +162,13 @@ static ssize_t fw_platform_size_show(struct kobject *kobj,
 	return sprintf(buf, "%d\n", efi_enabled(EFI_64BIT) ? 64 : 32);
 }
 
+static ssize_t tpm_log_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "TPMEventLog=0x%lx", efi.tpm_log);
+}
+static struct kobj_attribute efi_attr_tpm_log = __ATTR_RO_MODE(tpm_log, 0400);
+
 extern __weak struct kobj_attribute efi_attr_fw_vendor;
 extern __weak struct kobj_attribute efi_attr_runtime;
 extern __weak struct kobj_attribute efi_attr_config_table;
@@ -459,6 +466,12 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
+	if (efi.tpm_log != EFI_INVALID_TABLE_ADDR) {
+		error = sysfs_create_file(efi_kobj, &efi_attr_tpm_log.attr);
+		if (error)
+			pr_err("sysfs create file failed with error %d.\n", error);
+	}
+
 	return 0;
 
 err_remove_group:
-- 
2.34.1


