Return-Path: <linux-efi+bounces-1069-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF58CCA26
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 02:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED131C21603
	for <lists+linux-efi@lfdr.de>; Thu, 23 May 2024 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1163ED8;
	Thu, 23 May 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULad04mW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E3FA29;
	Thu, 23 May 2024 00:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425158; cv=none; b=nA9Y7AIJGpjaxAM6+tvXCgYaSSlQDg3VMAuNjKN4M+ZtO4i6m+2F4N4GhIVbvJSTUcAjqwXA1/XKmy3vqn6TgFcbz/chPSnlaJnufw61TIRIZra1GwcBEOjv7Agy4rTqnRp15kKGg1iiikLqJdUAUygtZ7FxUbWzNFx/NsXK36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425158; c=relaxed/simple;
	bh=2NXbVr11zlLfHaiiAOGTnIukR3huEwuayPb0UQVkb3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH4ENfxzJRrAZH89XF2GQxG80qakYNJduzmgA9Tn6ixqXHCZMqx5jSD17H5/rLTs6QGng8EYM2bdNLuzSWiRHmJe/g3+IxaBeCBgA+ak0QQjDlS9E6roBCq0E0zRaTXvNr4npKtqtXnzmxXdYFLp4cPuhntrQipCtjDzFora6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULad04mW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716425157; x=1747961157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2NXbVr11zlLfHaiiAOGTnIukR3huEwuayPb0UQVkb3U=;
  b=ULad04mWJ8K76JI5hKXGseS+cFdRO2InXbto57wfHurDJi1ffgHy+A6k
   SjrayBN8Cchtnqx1DN73n/iOFMfICKTQ0vTBQAELrQrSKrQCGKyCuHOIH
   ouKE1mPLeqTZvNrX+CkxDMKtVipmFZx+DtwU5B7A6xOcSvLeHm2haTJ5V
   3IePsfBqm8zB1/FWg/xLGyVYkcCwDEFw9OyigeWkH23qMhHkqTopoYrWB
   r1MZ+nfcYvJSVoTmB5++K8ovwk68GD/WAzrAXgamhATtkq3GWsUvFWypC
   eL+Ny/Rwc1tQKFvgWtfexH4S5XaWrZt6jvACNsM38ehtwpBsVgtDptN6z
   Q==;
X-CSE-ConnectionGUID: +50lwvwlS6iyFgi8h46/xw==
X-CSE-MsgGUID: VipcH2JzQKuMMx+BnDatXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12651250"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12651250"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:45:56 -0700
X-CSE-ConnectionGUID: n71U+gBtTVu8yyED6rs9TQ==
X-CSE-MsgGUID: Db/HnMh/Qjy/8Jwsgkvv8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38319442"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.68.11])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:45:56 -0700
Date: Wed, 22 May 2024 17:45:54 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Bowman Terry <terry.bowman@amd.com>
Subject: Re: [PATCH 4/4] cxl/pci: Define a common function get_cxl_dev()
Message-ID: <Zk6RwpfNYkS5N+ML@aschofie-mobl2>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522150839.27578-5-Smita.KoralahalliChannabasappa@amd.com>

On Wed, May 22, 2024 at 03:08:39PM +0000, Smita Koralahalli wrote:
> Refactor computation of cxlds to a common function get_cxl_dev() and reuse
> the function in both cxl_handle_cper_event() and cxl_handle_prot_err().
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> ---
>  drivers/cxl/pci.c | 52 +++++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 3e3c36983686..26e65e5b68cb 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -974,32 +974,43 @@ static struct pci_driver cxl_pci_driver = {
>  	},
>  };
>  
> +static struct cxl_dev_state *get_cxl_dev(u16 segment, u8 bus, u8 device,
> +					 u8 function)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
> +	struct cxl_dev_state *cxlds;
> +	unsigned int devfn;
> +
> +	devfn = PCI_DEVFN(device, function);
> +	pdev = pci_get_domain_bus_and_slot(segment, bus, devfn);
> +
> +	if (!pdev)
> +		return NULL;
> +
> +	guard(device)(&pdev->dev);
> +	if (pdev->driver != &cxl_pci_driver)
> +		return NULL;
> +
> +	cxlds = pci_get_drvdata(pdev);
> +
> +	return cxlds;

This can be:
	return pci_get_drvdata(pdev);


> +}

snip


