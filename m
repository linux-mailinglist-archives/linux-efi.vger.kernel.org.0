Return-Path: <linux-efi+bounces-4480-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD16B11D15
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8740D16C224
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 11:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA08C2D374E;
	Fri, 25 Jul 2025 11:04:12 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11B22F767;
	Fri, 25 Jul 2025 11:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441452; cv=none; b=GeyU0KUv5ME2J3347cPFDROaAj6C8laxnOh1/J980dkvHQ4ex8C80AMvPx3KqtjBFkFxz71lrdbTD9mn7Ged5jGIwjg5wXYegbnOGRzYzX6VgyC/kXxziA5ZkwpZidg88/XbmzZqKY8xn/iYYb9qbQcrxG05/2cYuTBHqkyAJlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441452; c=relaxed/simple;
	bh=SHg2aiCGfo4HynDoTvQeK06rOQbljdSDjYjCRw+z1K8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwlzBLIh5nHy0f9TvedLKYzsNon9BIR+iAeA67MgTDB0uHq5iMQo+8Fzs63fD8VjWR1ywJi4PRFcoPkv1EJxukyBYpuoX69KyfGc8upA6aEjofTWHU39zba8VdyORnTRAJtQQt0Ab1qv4MlIYVMekJcfumIqA8RhHiLZF0qUgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpQ275bFpz6D983;
	Fri, 25 Jul 2025 19:02:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B8DF1402FE;
	Fri, 25 Jul 2025 19:04:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 13:04:07 +0200
Date: Fri, 25 Jul 2025 12:04:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, Marc Herbert
	<marc.herbert@linux.intel.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ard Biesheuvel
	<ardb@kernel.org>, Alison Schofield <alison.schofield@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Dave Jiang <dave.jiang@intel.com>,
	<tony.luck@intel.com>, Gregory Price <gourry@gourry.net>
Subject: Re: "invalid agent type: 1" in acpi/ghes, cper: Recognize and cache
 CXL Protocol errors
Message-ID: <20250725120405.000032d0@huawei.com>
In-Reply-To: <2937432.AOxP5AVGnv@fdefranc-mobl3>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
	<074f5f77-7bef-4857-97fe-b68ee9b0afaf@linux.intel.com>
	<8e67a97c-530d-4a1c-ab72-3992a6c5db83@linux.intel.com>
	<2937432.AOxP5AVGnv@fdefranc-mobl3>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 24 Jul 2025 16:49:00 +0200
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> Hi Marc, Smita,
>=20
> On Wednesday, July 23, 2025 9:13:34=E2=80=AFAM Central European Summer Ti=
me Marc Herbert wrote:
> >=20
> > On 2025-07-22 12:24, Marc Herbert wrote: =20
> > > Hi Smita,
> > >=20
> > >   The code below triggers the error "invalid agent type: 1" in Intel
> > > validation (internal issue 15018133056) =20
> >=20
> > The same test case also triggers the other, warning message "CXL CPER no
> > device serial number".
> >=20
> > I heard that "device" serial numbers are only for... devices and that
> > even then it's not always mandatory. So maybe that other message should
> > be downgraded from warning to the "info" level?
> >=20
> > Marc
> > =20
>=20
> [skip]
> =20
> > >> +
> > >> +	if (prot_err->err_len !=3D sizeof(struct cxl_ras_capability_regs))=
 {
> > >> +		pr_err_ratelimited("CXL CPER invalid RAS Cap size (%u)\n",
> > >> +				   prot_err->err_len);
> > >> +		return;
> > >> +	}
> > >> +
> > >> +	if (!(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> > >> +		pr_warn(FW_WARN "CXL CPER no device serial number\n");
> > >> + =20
>=20
> Maybe this test should be written on the line of the following snippet ta=
ken=20
> out from "ACPI: extlog: Trace CPER CXL Protocol Error Section".[1]
>=20
> +
> +	if ((prot_err->agent_type =3D=3D RCD || prot_err->agent_type =3D=3D DEV=
ICE ||
> +	     prot_err->agent_type =3D=3D LD || prot_err->agent_type =3D=3D FMLD=
) &&
> +	    !(prot_err->valid_bits & PROT_ERR_VALID_SERIAL_NUMBER))
> +		pr_warn_ratelimited(FW_WARN
> +				    "CXL CPER no device serial number\n");

They are mandatory for CXL type 3 class code devices (and so the LDs here I=
 think)
Device and RCD might not be type 3 class code so it may be optional?

> +
>=20
> Thanks,
>=20
> Fabio
>=20
> [1] https://lore.kernel.org/linux-cxl/20250623145453.1046660-4-fabio.m.de=
.francesco@linux.intel.com/
>=20
>=20
>=20
>=20


