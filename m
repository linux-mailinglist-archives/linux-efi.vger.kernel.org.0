Return-Path: <linux-efi+bounces-5834-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC777CB6A2F
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 18:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F4E30133A8
	for <lists+linux-efi@lfdr.de>; Thu, 11 Dec 2025 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB26F315D31;
	Thu, 11 Dec 2025 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jhuQxZPi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C7A2C324C
	for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473357; cv=none; b=PxGD+cGM8cFaGl8O0Fr8BuQ+4X+pVO9JoGHaXLXqVolcSqoNxga48yaO6mdxIUAMLIy6LAs+DveZIgUCOfpAURjcqEhjUS2r45CQqWJoOpJZ46/hwr6+ejtSC+lPZuhu5XugfqyRSWAImDj/H05YNmt+l/YStIC8/9W5NQA599w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473357; c=relaxed/simple;
	bh=VskU/7ED+cd07+YT0cLSY6lSv8W33UJFXaXtUVFg16k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KkqSmt3y8fltMR+Wvoea0e5v8vw/bnsYdXsOt2vXh/rBk1grfWOMZowvpoSFlNJisICxjgqFQUdKo4Le3KUZgFWB7xOR3szlm30W9NMFSeBL2RmnEC8A9FaKrt8sKfPDwNpjkhwxZDUMPD/nvuW1VBtpwzMgWvPlRvBNEGUJD1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jhuQxZPi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso4064995e9.3
        for <linux-efi@vger.kernel.org>; Thu, 11 Dec 2025 09:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765473353; x=1766078153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMUEsjsV+UnHdVdxs42rX4kdIiZsjjM1yfHblt+Kr5Q=;
        b=jhuQxZPiHcY7x0568DsuGhznsk0hyID112CEv3uq3cwkECw2V2InlsjuFYIc2GBTpR
         AaDHquU/Hsq2idxE/2U7K/ZCc9YPiONwhqiWNQwswhqgsVNynZ+T/3qfMfVGkTK2XXhn
         FtXhCZfbQGMJMKiiNkrvykWmlrbwuyWGEmu0IWatmKUw5aOl7bM1fd7E+S7+boXx4AI8
         Of92W/RNysFIgQ2CrtZbr7SB+Tf9pWK8bOSduFdEy7HLMR7/nbrmC19IN6oIe3vrJdoo
         k16M1wLtScnPtrpDo/A0duGWOVFaZrJ8xvLNw+mZ1nCVcJHync3ZQFZCgjv0H5GzMMpj
         gFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765473353; x=1766078153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMUEsjsV+UnHdVdxs42rX4kdIiZsjjM1yfHblt+Kr5Q=;
        b=fh8qv+7UkTR6a2zQ86WwSvJKQB6dRjB/BRC9dDGK4c/mrReStUcT/k4tEqTNfezedJ
         CVIzaAbSyWeND2zxS3RDpk297+LqLblZF/9xJ9tS0WgJ+vIQGvHs3K2YymZ0O8mXTbdm
         qd6hTKWxLbyyAUFYuBhfp9WA5e+QqhbSbI4pDeeTcfffhFtYbgrX0lbjVTnvmUXGhuye
         G2Jtb9XCXcQZArUKb09TjZ4IaFFwn8lLe7vtGnPcZIlSg159Qk4Xk3F9o9dAsbqcud9a
         4gGehAH1HTPHgUmPNBvuvjN7Na7UtFBcCAr5S6dAaJQvv6r4sIsk+HQ5C1hC262bC65i
         94Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXXB2NdApeGE7oQJCI1OgNF1eadowsP1BCNRZOCBvauJleXNJZxVpxozxlIwn5OEmyqz1XBrP8GuU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmgUzdjZNi3mq8EHTv5CFjGIyv35sw1XopGZPkPFXEx8CVnOj
	Muhs9TqQadQknssl1FNcIDEx5ZF+EoEh4R9wYd2wpN1AQV/giXau5xbuandySDm/vqo=
X-Gm-Gg: AY/fxX6nQXb8PAATPCn9nB0SBsD1+K2MLFS0i/4hlojx3/ZLeOUeT6Mo0KJ8E5yiB/D
	DDsr1LAgrixc3pfQZFjSNpD7+wTfpBakjZEGzP8R4B1lsMpx25HpmGmn9R1SDqpgQRLJg9b1fk0
	1kkTLbmVwmP0+T/I1bzgd87qF5aOgg4OiyE8g8tNfmSkWoEYWiPYsMBnwILSl0ltNxxnBJZTk1P
	4CEWPO8nI8j9uhcNvxgG7Vxl93gkcaAL7/5yCkF9w7Ei+SuDaX21rWT4prKQQlsIKTTfsRaItU3
	mULmeBHandyLVrxCIkWTA+MeagX4sSLub6CRDNA+TE0X0isH/Dx/IYvpro909CUWRHArp5jdiJs
	RliBHX2stx8JgFrqe7pI6Ayi2HniABR02zkdn1K0FS+fqrwskhVoYQ5hcbUTs/Egij85x4LZjgu
	TEYYBJKMCRjSkDZ58XgRT2LE5mHRXjscph2AfpAbp2dNUrlPKYJy2iCwzFMM4mgkeCQpA7qkYsX
	jY=
X-Google-Smtp-Source: AGHT+IH1WdB9lpe0Nt0W2bI91FzFVq1XhPopqcW3gxsnNR/pZMKlmmN+J4cQvorBXPFQhPdkhqM0qw==
X-Received: by 2002:a05:600c:1d0b:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-47a8375ae3dmr83804315e9.16.1765473353260;
        Thu, 11 Dec 2025 09:15:53 -0800 (PST)
Received: from localhost (p200300f65f006608b66517f2bd017279.dip0.t-ipconnect.de. [2003:f6:5f00:6608:b665:17f2:bd01:7279])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42fa8a6fd62sm7327909f8f.10.2025.12.11.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 09:15:52 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>
Cc: op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v1 00/17] tee: Use bus callbacks instead of driver callbacks
Date: Thu, 11 Dec 2025 18:14:54 +0100
Message-ID: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3006; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=VskU/7ED+cd07+YT0cLSY6lSv8W33UJFXaXtUVFg16k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOvwTkOdNXplS+sYyTfjIHP/A8Gme4RZEpqcXt diRkMgNgISJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTr8EwAKCRCPgPtYfRL+ Tl1NCACRY8t0HOZ/pe2jgNYt83zctNNDYXhzu8cPsBYC6DoxIG7qbaEG/i2btzV7P9iWEXcGnaW iTW12DonZuA0Ys9v8JfYi5w/j0bn6FtrwKHIXypEwJzVzqmq0s9FhsPI+49irrtevJQOGtp/6FA ++4ZHclomZVYjG5ZORmnn0yLTtXHbQYEPcyHuzEEUvs+tHCIYIgkV7gzQ+qvpTw0lA+x5uFNqib OwGvVZIMvKV/HN70QhazY/X+w3FigDIT5y0g639i0H9JkEXX1mq5qRYi9kcC8z3WazU0iJ39L6Z w+blXNgg5fNZycKQ3GRhj80bk29PcQH7RHH6Vzov1GydnnYE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of this series is to make tee driver stop using callbacks
in struct device_driver. These were superseded by bus methods in 2006
(commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
methods.")) but nobody cared to convert all subsystems accordingly.

Here the tee drivers are converted. The first commit is somewhat
unrelated, but simplifies the conversion (and the drivers). It
introduces driver registration helpers that care about setting the bus
and owner. (The latter is missing in all drivers, so by using these
helpers the drivers become more correct.)

The patches #4 - #17 depend on the first two, so if they should be
applied to their respective subsystem trees these must contain the first
two patches first.

Note that after patch #2 is applied, unconverted drivers provoke a
warning in driver_register(), so it would be good for the user
experience if the whole series goes in during a single merge window. So
I guess an immutable branch containing the frist three patches that can
be merged into the other subsystem trees would be sensible.

After all patches are applied, tee_bus_type can be made private to
drivers/tee as it's not used in other places any more.

Best regards
Uwe

Uwe Kleine-König (17):
  tee: Add some helpers to reduce boilerplate for tee client drivers
  tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
  tee: Adapt documentation to cover recent additions
  hwrng: optee - Make use of module_tee_client_driver()
  hwrng: optee - Make use of tee bus methods
  rtc: optee: Migrate to use tee specific driver registration function
  rtc: optee: Make use of tee bus methods
  efi: stmm: Make use of module_tee_client_driver()
  efi: stmm: Make use of tee bus methods
  firmware: arm_scmi: optee: Make use of module_tee_client_driver()
  firmware: arm_scmi: Make use of tee bus methods
  firmware: tee_bnxt: Make use of module_tee_client_driver()
  firmware: tee_bnxt: Make use of tee bus methods
  KEYS: trusted: Migrate to use tee specific driver registration
    function
  KEYS: trusted: Make use of tee bus methods
  tpm/tpm_ftpm_tee: Make use of tee specific driver registration
  tpm/tpm_ftpm_tee: Make use of tee bus methods

 Documentation/driver-api/tee.rst             | 18 +----
 drivers/char/hw_random/optee-rng.c           | 26 ++----
 drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
 drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
 drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
 drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
 drivers/rtc/rtc-optee.c                      | 27 ++-----
 drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
 include/linux/tee_drv.h                      | 12 +++
 security/keys/trusted-keys/trusted_tee.c     | 17 ++--
 10 files changed, 164 insertions(+), 138 deletions(-)


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.47.3


