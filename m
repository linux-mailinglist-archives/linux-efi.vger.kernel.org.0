Return-Path: <linux-efi+bounces-1721-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD5D97790C
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 08:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5722EB24149
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B201BA87D;
	Fri, 13 Sep 2024 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NN4q5Sbz"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3033143C40
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726210782; cv=none; b=m61h+f+/itlNf2tESKcegoq1a9gQUffhwnw2/lPxPQCIPYdCd3ZTaqWP+eohqCN6OvPF7NZs4L/ZhVFcyaXuL8tavFUoKzVIuzPE2K9n5LuCqBd0l4gzhWfZnPOOnU9nIZQ9iqpRhAUeO68JtXhea5YJL3bouUYCKksu1fwh3z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726210782; c=relaxed/simple;
	bh=ShV9L2+m2YMDLJikbnfq0WaVdFpP9KMaCDxND8LBJXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKwv/GY6p2GaGq7CBSUm9FtGjNEuAvy3R0wBbdehVFPnpc1YTaxJQ/a/8h6D3i9gzs517tK4UvKDcZPr3//e5AkcCiD3gwPvYhhM11nX1HOekM/c3lSoGKDlknmk9MkbMdosFlSVgrU/MST4THPnDVGYTIE29vdGr3yWquiC5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NN4q5Sbz; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-27051f63018so265573fac.3
        for <linux-efi@vger.kernel.org>; Thu, 12 Sep 2024 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726210780; x=1726815580; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WGEhhXmzUtJuI/Eu5jyvUKPq++9pzn31gG5DMuWre94=;
        b=NN4q5SbzwrsWAJof1O4fMAFDhikxlWYTR2QFWiRnKtCKOe/Trzl3N+HzA1smGC5Wq6
         7OTdGSFK96ANra+AAaLZbHDikax2eQaAgzWESljY4SI+uN594OO4I/VUNKE0PrMqMVSs
         lrIX+Qb3Vf0RzYyRJSPgw2eAiwHMW3PQ2VR9JZ73veY/1JuNRNq7m2v1WG/xZuWfNvpz
         4MubYuKh6ZTAJGkcZ//qqGiWCjA+uzRBA6hHME8jbItVDgghlzfq/h/fUj6sL+9Xi8zN
         gTyR46nQjemHaO/aAB7FldOwOp9RMLTsxHVTdQmewS+l4b94Q5ZndkL8p2AV/00FeYYp
         bcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726210780; x=1726815580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGEhhXmzUtJuI/Eu5jyvUKPq++9pzn31gG5DMuWre94=;
        b=nnsAvsf0eQUEq3c6WJ27TCq/qAdjx8kv+q83qPvZcR64MKco/6SF5QwfjT3K0RqSqE
         sMSbV2f4sBbRf0Ee972Ty1Whrydk89wcXYk3u9lcXu9oApu7cXct3fiaDpEXupXbsT2I
         8lHTIeY/nbYbgLA3VNxFEhTuFKjXDNLNK+KQmsxx4/PH3xiy1nvchKWkdioegXKmJi5b
         /B5SVfm3nCIrHbKuGXRewO3DE2NdFlhnityAVl2Ju5P/EqXAr4yyAfqYe3TnDA2Ly+wz
         XpHxevG7Fh+0C2VPVvD9xsDftSLsHa+dWzi10VjLiMwqv/14H2A+umJtbh+ZLy7TpICl
         ZTJA==
X-Gm-Message-State: AOJu0Yyu2cLEkhctKDcjq36ntbWi98ZkDiRUYH2Cy/b+d3Au8QOIvrfu
	LAengNwlNdDM0w7iAdGUl6j1WyePky06fFDPgYXlhJRWEIs4ysi7J+K2C7DYEAC94jLBo7c88B8
	CSdjqCIEu9H7konEnofDOW50ewx9rHw9jMCiaybMNXp52qEP6
X-Google-Smtp-Source: AGHT+IH4x1Nyy2kdekN+2vcx0ajRcsHd0284Xn+MFt0Wjvy/NVo4Jer090xNhjugTxFqBBn6DLgvGUkMXHiHOqgMw/E=
X-Received: by 2002:a05:6870:56a2:b0:27b:6e04:d13a with SMTP id
 586e51a60fabf-27c68a154ecmr1156192fac.26.1726210779632; Thu, 12 Sep 2024
 23:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906202745.11159-1-gourry@gourry.net> <20240906202745.11159-4-gourry@gourry.net>
In-Reply-To: <20240906202745.11159-4-gourry@gourry.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Sep 2024 09:59:03 +0300
Message-ID: <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
To: Gregory Price <gourry@gourry.net>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, ardb@kernel.org, 
	leitao@debian.org, usamaarif642@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Gregory,

On Fri, 6 Sept 2024 at 23:28, Gregory Price <gourry@gourry.net> wrote:
>
> If get_event_log fails, at least provide an indicator of this failure
> to assist debugging later failures that attempt to interact with it.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/firmware/efi/libstub/tpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
> index df3182f2e63a..192914e04e0f 100644
> --- a/drivers/firmware/efi/libstub/tpm.c
> +++ b/drivers/firmware/efi/libstub/tpm.c
> @@ -185,8 +185,10 @@ void efi_retrieve_eventlog(void)
>                         get_efi_config_table(EFI_CC_FINAL_EVENTS_TABLE_GUID);
>         }
>
> -       if (status != EFI_SUCCESS || !log_location)
> +       if (status != EFI_SUCCESS || !log_location) {
> +               efi_err("TPM unable to provide Event Log\n");

s/provide/retrieve/ and yes the print is going to be useful.  Do you
know if the EventLog is mandatory. Reading at the spec GetEventlog
only has 2 return values, which implies you can't return "Not
supported", but it's not explicitly stated anywhere

Thanks
/Ilias
>                 return;
> +       }
>
>         efi_retrieve_tcg2_eventlog(version, log_location, log_last_entry,
>                                    truncated, final_events_table);
> --
> 2.43.0
>

