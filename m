Return-Path: <linux-efi+bounces-4474-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ACEB10DFD
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544E717D976
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 14:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86615257423;
	Thu, 24 Jul 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jacnJxvV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AE1C5F23;
	Thu, 24 Jul 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368551; cv=none; b=lT7qnnuDeMX3znnLbhS6Gq+1uC2Fg1C66Hci4Kv7K+eOLSJayHCZ+wkkeOdeQi9eUzoqnf02QxLREf+vYHsj+JEeMz4wS5T94hRqnbgvxE/EyJHRYlBDeqicir8HyAr8mjoDUOgtGllZZuPoY4k255/OpXebheKZ+6lQyA+qJ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368551; c=relaxed/simple;
	bh=+1jGV/EWgej+IBnO2zK32E3tSlPZmUCnL27o7aDh9co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdlw7KXw0D4yBa9sbBbPehlsIjyUJSjIkm+kk1D8c52Zxd+ZPa8bBVQaGp9p8T/9p8AtNnpy5BwGKAbVSojDMaIE7iUSu5/zuTwYWqt/+30omRrWA3DZS2lRFDe6uz8yVjAjorh9Obs0IqUHok/gG+l16RkWvvOgu8tk30oQk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jacnJxvV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753368550; x=1784904550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+1jGV/EWgej+IBnO2zK32E3tSlPZmUCnL27o7aDh9co=;
  b=jacnJxvVUarlMWqrvbOSty/8VIe+oPzSD7WP4LmfkTztw1lh8K6zrvHz
   pdLdBKjux/aJmW7zxeD4jykroUsoltS4eE5Puuj1YprXBDy5Ei2XRCgEO
   maRdERjeB2St0xC9db5IJGXyGtX1SMn1RnIgNGC3aVpnEGMr9q7rwmL/1
   XdVfkUaywrKbHVQBGkYatHrf1hX1Vsor4QgPIXydp3+lXvEu9cjXyT7bE
   UDEqlmrBmaJTGfUyXhpTFjmM2M+V4pMnW3UfteOz7LAiJhlO48Os7LZt8
   i/huvwIznLp5x4xa5b81aUJQqiOb4sj6lB6dl3QcclXPN2dECNreoVh3i
   w==;
X-CSE-ConnectionGUID: RsD4tHKFRqKMS8IkWLIisw==
X-CSE-MsgGUID: 4zuQ0QB/TB+sgPAvyBEYCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="67041233"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="67041233"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:49:09 -0700
X-CSE-ConnectionGUID: BaonTbe/TGijFh1Y1d/24A==
X-CSE-MsgGUID: hGhbahudS2+OmHAEEh8s5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="159845710"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.245.246.151])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:49:03 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Marc Herbert <marc.herbert@linux.intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>,
 Dave Jiang <dave.jiang@intel.com>, tony.luck@intel.com,
 Gregory Price <gourry@gourry.net>
Subject: Re: "invalid agent type: 1" in acpi/ghes,
 cper: Recognize and cache CXL Protocol errors
Date: Thu, 24 Jul 2025 16:49:00 +0200
Message-ID: <2937432.AOxP5AVGnv@fdefranc-mobl3>
In-Reply-To: <8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
References:
 <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
 <8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Marc, Smita,

On Wednesday, July 23, 2025 9:13:34=E2=80=AFAM Central European Summer Time=
 Marc Herbert wrote:
>=20
> On 2025-07-22 12:24, Marc Herbert wrote:
> > Hi Smita,
> >=20
> >   The code below triggers the error "invalid agent type: 1" in Intel
> > validation (internal issue 15018133056)
>=20
> The same test case also triggers the other, warning message "CXL CPER no
> device serial number".
>=20
> I heard that "device" serial numbers are only for... devices and that
> even then it's not always mandatory. So maybe that other message should
> be downgraded from warning to the "info" level?
>=20
> Marc
>

[skip]
=20
> >> +
> >> +	if (prot_err->err_len !=3D sizeof(struct cxl_ras_capability_regs)) {
> >> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> >> +				   prot_err->err_len);
> >> +		return;
> >> +	}
> >> +
> >> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> >> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> >> +

Maybe this test should be written on the line of the following snippet take=
n=20
out from "ACPI: extlog: Trace CPER CXL Protocol Error Section".[1]

+
+	if ((prot_err->agent_type =3D=3D RCD || prot_err->agent_type =3D=3D DEVIC=
E ||
+	     prot_err->agent_type =3D=3D LD || prot_err->agent_type =3D=3D FMLD) =
&&
+	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
+		pr_warn_ratelimited(FW_WARN
+				    "CXL CPER no device serial number\n");
+

Thanks,

=46abio

[1] https://lore.kernel.org/linux-cxl/20250623145453.1046660-4-fabio.m.de.f=
rancesco@linux.intel.com/




