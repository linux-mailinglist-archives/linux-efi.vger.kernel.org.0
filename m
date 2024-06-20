Return-Path: <linux-efi+bounces-1250-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830790FDD7
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A00F1C21949
	for <lists+linux-efi@lfdr.de>; Thu, 20 Jun 2024 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E748CCC;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwIME/ux"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14F21364;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868863; cv=none; b=QCUcREFW/3Umj4yxOU6cm+WA+gUmBkpEeLQ7yplNA8WmwFMI1r8mjUuw90dhc5FRCb6X41Cx9lqpl8MhLwi80P8aHg2qvVnDaJae9xJeMbiJIGXX61nm37xMH1wHlEGsP2U5b14JM2qWDfBQ3wDjRIAl9SvGh8sm3NmKqZiiNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868863; c=relaxed/simple;
	bh=6JuMeq7sjETxb1LKNx9oEk6LalPPSLEpZS4h05xsdB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvdqY3CIJVGCO4Pm0vo9Rky6ymTi+LVamKAMHV8kTM9Yq2mPhFOUZoMXxndEM+Ppi00ilMONqb90EH12qisYV3Yh9AveaeoHbrIneXtDiAiU0MH/iBX56bWisimeFOazZTK2caFh2m6UyQyd+cFHODLNv+WOInVdvAxK2I1D6ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwIME/ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DABC4AF0A;
	Thu, 20 Jun 2024 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718868863;
	bh=6JuMeq7sjETxb1LKNx9oEk6LalPPSLEpZS4h05xsdB4=;
	h=From:To:Cc:Subject:Date:From;
	b=iwIME/uxZah+g4jjsEsY55NmZGytI97VQKktzrRZWzmMmWfmQygY8/7fxKvOKS1KT
	 RqeQnZPDRcNGp3SRVBsIVlWD45ACJJVtoCZWdW7YwEOrAFDCgG0RVgFAvRIZGH9kL5
	 lGqit1ZhygGdVc5JA4xlFC63aGNNlk87BzbjFq+XOZtHPAur3lYHeMJvGohQvfddyJ
	 IkN+e709kNje+mON574YhE2yHyxbnIWuX09boLUjKAMce7loIOR9MIJxxBGt0qqCZa
	 EAVQRslsRw/4zfS7g/KVfYh+YYsFvgH9WyMsYGlLqcwaVYENzN2k47t6a3pY7HnPI0
	 l+dEzkFFLtV5A==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1sKCJI-00000003bzz-3FRl;
	Thu, 20 Jun 2024 09:34:20 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/3] Fix CPER issues related to UEFI 2.9A Errata
Date: Thu, 20 Jun 2024 09:34:11 +0200
Message-ID: <cover.1718868693.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

The UEFI 2.9A errata makes clear how ARM processor type encoding should
be done: it is meant to be equal to Generic processor, using a bitmask.

The current code assumes, for both generic and ARM processor types
that this is an integer, which is an incorrect assumption.

Fix it. While here, also fix a compilation issue when using W=1.

Mauro Carvalho Chehab (3):
  efi/cper: Adjust infopfx size to accept an extra space
  efi/cper: Add a new helper function to print bitmasks
  efi/cper: align ARM CPER type with UEFI 2.9A/2.10 specs

 drivers/acpi/apei/ghes.c        |  9 ++++---
 drivers/firmware/efi/cper-arm.c | 47 ++++++++++++++-------------------
 drivers/firmware/efi/cper.c     | 40 ++++++++++++++++++++++++++++
 include/linux/cper.h            | 11 ++++----
 4 files changed, 71 insertions(+), 36 deletions(-)

-- 
2.45.2



