Return-Path: <linux-efi+bounces-2109-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B5D9B9D6A
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 07:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA244B21D21
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5123E14A0A3;
	Sat,  2 Nov 2024 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uV7o7pOr"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105119474;
	Sat,  2 Nov 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730528599; cv=none; b=Mn+ItchDEpys2yDcG/cd68RZ7MNcc1IaABLxNNz7HEyIef+TS8zAGhExuNZsmGkV5sXas1WgRN5ikCYgUKSFrdlPBR8/jdFGz2D3niImQJbgZzkQbs//ZPpElFsdpIq0FLcC02FyBeoxQX5Gg5Nb9Qbk2adGbMxDoRQvOPhAH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730528599; c=relaxed/simple;
	bh=NY0xcRqGkYBk6+Iddjn1WeUvmoSjuS6NoFtXitHCID0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poV9yNOGaJzepvXFzAEWZdMCUkpEuPh/qKFkZfdrNq119pJjPRUSjo/8/FpYlW18Q0SNATkxHqRcrisw5NXcl5mXV3VWbIGfBymCWg8VSoyt4Lrr0mOTsmKceySbWhaRcKJdv5Lyi5erI6LSEi49v+JWgABQxc9r1mAbzNixuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uV7o7pOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59A8C4CEC3;
	Sat,  2 Nov 2024 06:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730528598;
	bh=NY0xcRqGkYBk6+Iddjn1WeUvmoSjuS6NoFtXitHCID0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uV7o7pOrKf9LSTRyEOabwTBsOog6I7KPkza7UGoUxg1Xd+xU07PDpBzcVsPypJyq4
	 K+3gaFSR4nWjuiQwKoI0B16X7FxC3485i9dR1dnz1mkBfdVHQy3OMWlz1MbXRAwiZj
	 uvPuMuR8X6okk1idTIHZ9wiNiGt5EAOL+tys3W4DNSymZotpPvt39IQ2xBVNTfNFmo
	 HjHnP6H30hx4tt4BaHCrbgR+O6D0COycWSDU2rNfbHqUArAYgWHMz/CyTl+OGmnyIi
	 xSBPF9Oc+soqtNrmQKbbC1Rz5VZpRHfoppBTRrIN7CeIx4YsFHgf81ZvaJgmtnKLTM
	 Hvb3IVJ5+8OaA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: jarkko@kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James.Bottomley@hansenpartnership.com,
	andrew.cooper3@citrix.com,
	ardb@kernel.org,
	baolu.lu@linux.intel.com,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dpsmith@apertussolutions.com,
	dwmw2@infradead.org,
	ebiederm@xmission.com,
	herbert@gondor.apana.org.au,
	hpa@zytor.com,
	iommu@lists.linux-foundation.org,
	kanth.ghatraju@oracle.com,
	kexec@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luto@amacapital.net,
	mingo@redhat.com,
	mjg59@srcf.ucam.org,
	nivedita@alum.mit.edu,
	ross.philipson@oracle.com,
	tglx@linutronix.de,
	trenchboot-devel@googlegroups.com,
	x86@kernel.org
Subject: [RFC PATCH v2 2/2] tpm: show the default locality in sysfs
Date: Sat,  2 Nov 2024 08:22:57 +0200
Message-ID: <20241102062259.2521361-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102062259.2521361-1-jarkko@kernel.org>
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org>
 <20241102062259.2521361-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ross Philipson <ross.philipson@oracle.com>

Expose the default locality as read-only attribute through sysfs.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- A new patch.
- Import from the original Trenchboot patch set.
- Drop the store operation.
- Tested with https://codeberg.org/jarkko/tpm-set-locality-test/src/branch/main/src/main.rs
---
 drivers/char/tpm/tpm-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
index 94231f052ea7..4f5e60b1e4c9 100644
--- a/drivers/char/tpm/tpm-sysfs.c
+++ b/drivers/char/tpm/tpm-sysfs.c
@@ -309,6 +309,14 @@ static ssize_t tpm_version_major_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tpm_version_major);
 
+static ssize_t locality_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct tpm_chip *chip = to_tpm_chip(dev);
+
+	return sprintf(buf, "%d\n", chip->default_locality);
+}
+static DEVICE_ATTR_RO(locality);
+
 #ifdef CONFIG_TCG_TPM2_HMAC
 static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -336,6 +344,7 @@ static struct attribute *tpm1_dev_attrs[] = {
 	&dev_attr_durations.attr,
 	&dev_attr_timeouts.attr,
 	&dev_attr_tpm_version_major.attr,
+	&dev_attr_locality.attr,
 	NULL,
 };
 
@@ -344,6 +353,7 @@ static struct attribute *tpm2_dev_attrs[] = {
 #ifdef CONFIG_TCG_TPM2_HMAC
 	&dev_attr_null_name.attr,
 #endif
+	&dev_attr_locality.attr,
 	NULL
 };
 
-- 
2.47.0


