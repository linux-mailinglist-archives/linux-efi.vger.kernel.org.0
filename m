Return-Path: <linux-efi+bounces-1018-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12F8BDE6B
	for <lists+linux-efi@lfdr.de>; Tue,  7 May 2024 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0EA1F2591B
	for <lists+linux-efi@lfdr.de>; Tue,  7 May 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081114D710;
	Tue,  7 May 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0Kb1CCE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D25B1E0;
	Tue,  7 May 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074518; cv=none; b=VpWUrXio+5UWH6K2tDebpmneDdxkZ9O++iGDn2vWlguMJ1B5tXpA+ZLousz2gXCjccH3M9r7adHIu/H59K7FM75sDL+b0v+JPYp9IpCSWdcS4TW/8oykwwBwyiRAsrwRLGNiP3Pf0ed/PsrIkodnfvSPw9084csjMsubFcxp4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074518; c=relaxed/simple;
	bh=Mi58uVSDi+5iePNr8b+aVN0PSLs4Zw96zhsxEeRqYmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhvkUqyBAFVgq+pIfEa27ts4YkZ54eaoTW4iM8VhBFnD9fr0XnHgpgqBAyHWXTHDsqm1kPCs1iRYpqB17N7Mnbf3rCqDbtInyiFyev/A04DmiRon+EJImHb+o4jS+c9XTMnKiPsaJft62fRgHMy2a8yFgHA8D0xMRnCRQSzU/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0Kb1CCE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715074516; x=1746610516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mi58uVSDi+5iePNr8b+aVN0PSLs4Zw96zhsxEeRqYmE=;
  b=f0Kb1CCElH2s0NtHZN9vrxssW0dato7Y3zPkKX0LBLcw69wtcmAf+TBq
   l/uO12yE8pkl5wBCmQOS4ULoVcC2KnHgFn6lasRfd1VxwRTxilSfvaJgW
   T0MZqapWfXT9A11ugQTsFKZVeS1ij4Bg661w8s0NBDiUh+TX4qqa65Iqv
   ATE/16Td/R8lzn2NCiS4SvAz1gfQ1Iw7LKRxSue36oe3gR4PeeuWKBZUK
   IiJDdgLHbnOaLcacUML+J50PIP8/S0+KCB6KPPNjXO/PiMD+iFu+4nIGW
   TADhbyohG+YL4joV5gk3SD1S+rIVbQdz5UR/k0DFV5UH4yN3ophC6SDDl
   A==;
X-CSE-ConnectionGUID: k6iR+1LGRnuafXBASfEWDw==
X-CSE-MsgGUID: gIzHRv1nTFW+9P/+t8QS+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="28329410"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="28329410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:35:15 -0700
X-CSE-ConnectionGUID: mbnN2bOrQTSC4WJUNs+SKg==
X-CSE-MsgGUID: xehOBnBQQpmFgGKtOm2zIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="scan'208";a="33029128"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.31])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 02:35:12 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 0/4] acpi/ghes, cper,
 cxl: Trace FW-First CXL Protocol Errors
Date: Tue, 07 May 2024 11:35:09 +0200
Message-ID: <2649256.vYhyI6sBWr@fdefranc-mobl3>
In-Reply-To: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20240109034755.100555-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, January 9, 2024 4:47:51=E2=80=AFAM GMT+2 Smita Koralahalli wrot=
e:
> This patchset adds trace event support for FW-First Protocol Errors.
>=20
> This series depends on:
> https://lore.kernel.org/linux-cxl/20231220-cxl-cper-v5-0-1bb8a4ca2c7a@int=
el.
> com
>=20
Hello Smita,

I'm working on a small series of enhancement and additions to kernel logs a=
nd=20
trace events in extlog_print() (ELOG). I'm interested to reuse from ELOG th=
e=20
infrastructure which you made to trace the CXL Protocol Errors.

I'm aware that this series depends on an old one from Ira which has been=20
superseded by a different implementation and, furthermore, that this needs =
to=20
be reworked   because the execution of this code may sleep while in atomic=
=20
context.=20

I'd like to ask if you plan to fix and rebase this series to a current cxl=
=20
branch. If so, I'll wait for the next version to integrate in ELOG.

Otherwise, if you are not anymore actively working on this series, please=20
notice that I'd be glad to help by making the necessary changes and by port=
ing=20
your code to a current cxl branch (of course, retaining your authorship).

Thanks,

=46abio M. De Francesco
>
> Link to v1:
> https://lore.kernel.org/all/20240102150933.161009-1-Smita.KoralahalliChan=
nab
> asappa@amd.com
>=20
> Smita Koralahalli (4):
>   acpi/ghes, cxl: Create a common CXL struct to handle different CXL
>     CPER records
>   efi/cper, cxl: Make definitions and structures global
>   acpi/ghes, efi/cper: Recognize and process CXL Protocol Errors.
>   acpi/ghes, cxl/pci: Trace FW-First CXL Protocol Errors
>=20
>  drivers/acpi/apei/ghes.c        | 22 ++++++++-
>  drivers/cxl/core/pci.c          | 29 ++++++++++++
>  drivers/cxl/cxlpci.h            |  3 ++
>  drivers/cxl/pci.c               | 13 ++++--
>  drivers/firmware/efi/cper_cxl.c | 79 ++++++++++++++++++++++++++++-----
>  drivers/firmware/efi/cper_cxl.h |  7 +--
>  include/linux/cper.h            |  4 ++
>  include/linux/cxl-event.h       | 31 ++++++++++++-
>  8 files changed, 166 insertions(+), 22 deletions(-)





