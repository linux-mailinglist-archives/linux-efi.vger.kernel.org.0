Return-Path: <linux-efi+bounces-2753-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1BA29A90
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 21:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E00169026
	for <lists+linux-efi@lfdr.de>; Wed,  5 Feb 2025 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD69213224;
	Wed,  5 Feb 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iTizeO0r"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B21D6DD4
	for <linux-efi@vger.kernel.org>; Wed,  5 Feb 2025 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785723; cv=none; b=Pbks06oLyJRbeSF3m56+AgG2k0r70d2NuaS++G8UA9Ws3fhiPqAURfzSXqNp43E2eo8CiJ5YV5V3WifLABlU1bAtznpI31bH7oAM6VvToN8Z/+9gsUZbrzuXRqAJhFJ2f7Di/+qFIFyzxN8iroaeQJpwbEfN19gGhUOakk4PEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785723; c=relaxed/simple;
	bh=DTEdzO1IPs/iSbUR9qTXfHT/WQX6NcWLD+GyM4n0aio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6FIX2cMLY5ktOVAVh1Ye2Pik0o8MNe5SmTwS3OtJnQEmrqL3+TQiiiULXGRLqYu51fH/M6SgKzGBqt2VSi1+30JweUTQe/wDRtmMOe/s2Xai1zfGwPRjxaErXUU1wtc0casu6bS0y4rR9W5vUh5TnlXKIS3L3Zdj2eQLiO8GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iTizeO0r; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd43aa1558so1832096d6.0
        for <linux-efi@vger.kernel.org>; Wed, 05 Feb 2025 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738785720; x=1739390520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VSpDNdk25O/o+fZMp288PyURrK/8ijexeUi7ezV/7c=;
        b=iTizeO0r8Q+SRPcDmjAneRsrBLngOQZuafT9vZ/vSQRDumKLFpdr7DSF2z1JGnAdw3
         hMnMBxrkLlV3iM7VYjqnqa9zh3xAHpC8GScBf28XzHnognANSaih+MXQzmWmvICOSLUb
         83JILGv+KliLiSI2Xh1RuTARjLFjrBN2b9NiVam/PJEYOw41GHHiKfPOfSPLt/z/gzWh
         tlW0WWvqEIuLiGF4KvChHc5wcsIr2w0IaHTup2aoNkNWwAupWpiofjdJay2hzFo4NLNI
         mhQb05IAdSD4Bc11fMKZEUQyvcqrdhjWCLkRGEKKoYko4cPkl5AiBThijVBDBt/qqpUI
         65mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738785720; x=1739390520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VSpDNdk25O/o+fZMp288PyURrK/8ijexeUi7ezV/7c=;
        b=AKp49IGOL6yX7r14egUDE0JCEjf+D4UpqfNYysNcqpKtJ4elhohK94S0kWOSF4bEDd
         ikiw9hsIuimAQ64BKVZbHTTcJ6gRnpQ77iVP6uQ80k/RZkPq634M4pDslql2ejVMrvQC
         dQo82zfVnXj+78N87RisRbXoYMqclXOGP9aVwepOD53q/h/2Odw8rUeujxVTzDhENq5U
         DKCiXFpPkQbrLZiFV7+nB5rH6OIvLm3yVF38w4V/dGom0h+7bC+nlvRRd4vTpmBucMgI
         UqZNq4Ga9rmJkETvD/r0zflM+QKZb26Raqy1JomZFSo7liXbRargkQKaZE3DNuK+m1Ej
         26ZA==
X-Gm-Message-State: AOJu0Yy991M9CLo7q3bdtR6oN7br39+FX7fAObeolob97OsozG8P6yL+
	CSylKlkxX0S7/LrKVRjo+EZjyy/SpoQKxv7xY3vqvixDv+YZez5aaHFmxRq7k7c=
X-Gm-Gg: ASbGncv8NcRq8Fidbnrvp8dSXrHyUs3NAf/zfCfKX694+e6K1eoiQ6F13fro8beH8N7
	drmHs2rPspEa+H9n5iZM9Givsyiea0K6pUJ6Efzn/AgGPj9Qnn8tUS7zOUHQd/3SbVN2UFfCCET
	RMrC6u5MIEjNN31Nzx7+CEAV4n3FxiO9+/KjK/m2plTcP3fjXVKqkEH1AYtNfbI2InJlNJtSpy5
	Rxk3RHT0MicsGM6nhUDj3qdQ7b7tfCmJSYymvHNtwnyofnv+VOcemfsocmTs2um+GkYyqPOnL91
	JqfvtD/xwnwoDNqByDFgl6pfdH2MmxzpqhiieRoj3KtfqbVk8e+6rqc3ZctTozq6KSQ/2AgeWA=
	=
X-Google-Smtp-Source: AGHT+IEYVi/m8wptbaxkhbPZJ+EcqbJYgjUqN7w7U6N9+LnXprFFxitg56LH3NaoPg3BvPn36ADc1A==
X-Received: by 2002:a05:6214:f6c:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6e42fbacae6mr68306776d6.19.1738785719721;
        Wed, 05 Feb 2025 12:01:59 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e4390abbf9sm2594556d6.94.2025.02.05.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 12:01:59 -0800 (PST)
Date: Wed, 5 Feb 2025 15:01:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v6 6/6] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
Message-ID: <Z6PDtW0omzmMjjXN@gourry-fedora-PF4VCD3F>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123084421.127697-7-Smita.KoralahalliChannabasappa@amd.com>

On Thu, Jan 23, 2025 at 08:44:21AM +0000, Smita Koralahalli wrote:
> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Use them to trace
> FW-First Protocol errors.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9d4b5f39b21a..766447c169c8 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1168,6 +1168,7 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
>  					    data->prot_err.agent_addr.bus,
>  					    devfn);
> +	int port_type;
>  
>  	if (!pdev)
>  		return;
> @@ -1176,6 +1177,18 @@ static void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	if (pdev->driver != &cxl_pci_driver)
>  		return;
>  
> +	port_type = pci_pcie_type(pdev);
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    port_type == PCI_EXP_TYPE_UPSTREAM) {

Almost wish this was a macro for the sake of style, but not worth it.

"corr_prot_err" and "port_prot_err" kind of blend at first glance. Not
worth holding anything up.

> +		if (data->severity == AER_CORRECTABLE)
> +			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> +		else
> +			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> +
> +		return;
> +	}
> +
>  	if (data->severity == AER_CORRECTABLE)
>  		cxl_cper_trace_corr_prot_err(pdev, data->ras_cap);
>  	else
> -- 
> 2.17.1
> 

