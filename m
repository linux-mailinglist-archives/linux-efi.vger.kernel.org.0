Return-Path: <linux-efi+bounces-464-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F268487EA
	for <lists+linux-efi@lfdr.de>; Sat,  3 Feb 2024 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81E1285CEA
	for <lists+linux-efi@lfdr.de>; Sat,  3 Feb 2024 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35925F873;
	Sat,  3 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUw2T3xf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999605FB83;
	Sat,  3 Feb 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706981481; cv=none; b=tgGPSJ1SL7k7/UqnghdVNmApHBvBHFbmAPNiNo1Hz/3QQ+eCmYBPFnNsFBEhuYuw595etDSvSyG3l8IJvNNH4idatjiBwkgPb9C/+VjhCyHs60KyT+stRqHNboSSeXQRKJ2WLIjw2AAwzH++khdnlzIZzJ37V5fRoQRNoZUX6HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706981481; c=relaxed/simple;
	bh=9gqp+2Ljc8JtlBy1OWpUwEYnoIf1Gb1jf8TyTUU3epo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prN1rAzRiVGuZn89/aGi488Uj7GoG6dCRQ+ky3yBARcL9bx/ge/eCeruCBFWUygzbaXW/pdyDI/lGxzLpOhnsHOzEIH4m8FcPP3Y68rvNOUVx4PZzzh8MizJqO0JHTcWbiLfW4MdKYkdurqEg0i13Sxfk3YS7Kid517bpylPr8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUw2T3xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2909EC433B2;
	Sat,  3 Feb 2024 17:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706981481;
	bh=9gqp+2Ljc8JtlBy1OWpUwEYnoIf1Gb1jf8TyTUU3epo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oUw2T3xfWD+BcuKXa4La7vJY5CY+U65GwgWWCacbpQllCOvjW4McBgAYfL/dmLfgM
	 C0nS5AiNAYBUEginHS5+mvm8Y6G7PWXQ8YRgqEQeALV+ED1BKD/GEwatbao7JQ16Yn
	 ac57hMyJs0odxQ23bnikLSV+jzFMC86HgHxYYZcnwvJZK8S3zeFSiQxxZEig02MFzM
	 KRK/qsRau6lwRGklZ9vJgqWOWQHhuowU+RFoSQR9+24S14U2ykK/0mnJHmUbP97mZa
	 bFfKa5kZC0omiYE9z0+MyKzWYjIEmsSO3G4W0rQ2gs1afKQBEt9UjNK3jR4cPy2Ajd
	 nslM5+sYbKacQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51142b5b76dso1209431e87.2;
        Sat, 03 Feb 2024 09:31:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxYbGKo7NuEMd7NqNmN5V6q+O/hCA2sC0LNi9sOVCLjSZuyopiD
	Wb33WygYo6i5h7tgNRDqHE6pC9gbfItnnpQTujVFFLYwGETtXPEnP7ELmjEPwBWhyu0yJQ2rbGZ
	Zaofu2bXgy3qLO7G2RHhry7J+PrM=
X-Google-Smtp-Source: AGHT+IHukFg7dN0iuA7Gi2zwXtdNwJw7ZD3kr0OLumU/XZ6fGUc5R5UxzRKsRGshds/2kUozoM/Mu+3yrZ0+2ZydG1Q=
X-Received: by 2002:ac2:5547:0:b0:511:3763:7f59 with SMTP id
 l7-20020ac25547000000b0051137637f59mr3027116lfk.26.1706981479305; Sat, 03 Feb
 2024 09:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
In-Reply-To: <20240131-cxl-cper-fixups-v1-0-335c85b1d77b@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 3 Feb 2024 18:31:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjuzOMNADnUyobYqPfW-h4FkN_N+UHkXYvOKgqGrKgQQ@mail.gmail.com>
Message-ID: <CAMj1kXGjuzOMNADnUyobYqPfW-h4FkN_N+UHkXYvOKgqGrKgQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cxl/cper: Fixes for CXL CPER event processing
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 00:55, Ira Weiny <ira.weiny@intel.com> wrote:
>
> A couple of fixes for the new CXL CPER processing code.
>
> The first is a real bug which should land in rc.  The second could wait
> until the next merge window but it small enough it should be ok to land
> in rc.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Ira Weiny (2):
>       cxl/cper: Fix errant CPER prints for CXL events
>       cxl/trace: Remove unnecessary memcpy's
>

Thanks, I'll take these via the EFI tree.


>  drivers/acpi/apei/ghes.c    | 26 --------------------------
>  drivers/cxl/core/trace.h    |  6 +++---
>  drivers/firmware/efi/cper.c | 19 +++++++++++++++++++
>  include/linux/cper.h        | 23 +++++++++++++++++++++++
>  4 files changed, 45 insertions(+), 29 deletions(-)
> ---
> base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
> change-id: 20240111-cxl-cper-fixups-dbf61790e4c8
>
> Best regards,
> --
> Ira Weiny <ira.weiny@intel.com>
>
>

