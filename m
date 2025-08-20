Return-Path: <linux-efi+bounces-4574-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50239B2D430
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 08:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E859D1889755
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26945259498;
	Wed, 20 Aug 2025 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ir/XRj+l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD382C11DA
	for <linux-efi@vger.kernel.org>; Wed, 20 Aug 2025 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672294; cv=none; b=RXmAARTjeq9QbnoF8f8pqB8A7dBY9x/xm0xUdK3Lb88GKUh47dew/PlnclXlycfox5DQ40umIV5iBj/dxM0pd+0mWl4ntRLhnRxyRkayfl3gU8wJ6/6k3jcZuSBQauWq8+Eow/9yBjrYOqVJLD/cl5uovE7qPC6+Z7/+L0whwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672294; c=relaxed/simple;
	bh=XxAiAdPjAqjFYBsF4crlxMLuqhWcBn41XRHdA5KQdTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9jSDsRdi2qYRZvZwk25TU+nkxOOM2OlcdHJzC+Rr+Iu9T/DHn/bo/oY6/ns9XzCAwyZApwiBPbB4Mcp43BcjPEd2qBaD5csnrluoV8QNzQG15+x27ZEWy0olUtfd2h5V5YIr2ftMZA6URrO8fyfp0O6lQfohPkLKPfkeLIVAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ir/XRj+l; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e93498d436dso2919564276.1
        for <linux-efi@vger.kernel.org>; Tue, 19 Aug 2025 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755672291; x=1756277091; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MFZtmVxFhnecSgkfjhLHB+6EKVJkLrQoIKfKXYcuIYU=;
        b=ir/XRj+lrRXUx6mTXOqiTkJ2oJHu/bMcqRe4t/JcEXbL9VqaDanPUsJ9F58L92L6zb
         hfMq7NBuOISfUDu2ImnFNdEV44fKzyFHOutscTEqHgsFJeTmqXgwOIgFxKfUc3h7BSH5
         t9Ol+kEyy6KXna7XKxFCxigjo4DIQuN0gRGxkLqSsBQmeo5qlJSGude188L2RX8TQhab
         hhbmfDzsCnQawQ5no9VuqsUpgaQtCqIJ8vzE2He6+e9zHdtf/bcH0AoZgDwgiZUckAhL
         MvkUaEOArTJ0z6cv+HgMANgGR2Yq4IdX3QIsEgrEpKOoBim49pFKgb6tqOSHxT85gzC3
         2R/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755672291; x=1756277091;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFZtmVxFhnecSgkfjhLHB+6EKVJkLrQoIKfKXYcuIYU=;
        b=ZLQxXOwPZII4FwDejgm6//x05s3PpvRUx93rs3aH0w2kfNLQqhuNKpnohgSXMjI/+9
         cd1LjNnug89g+flZyCA6FFrsil0QOtNOD984Eww+qptOtXqoiwAZz6w3BWeD0H+lKKOX
         GduZvk+DTx3qtHYnMir8lQ+8jQH/izsXLgzAE4JOORWuiedur2LfTeweggoN4jq3cSFy
         1bwnEp05n1pfqGvV4dAOWIfnzao+T2hycduZzR7GJSg0jEjLX+9fASj/VB838qTERkd0
         rFkDi1SBAmPN9qWfEeSBJZQXQHRN9RJxSkW1Dx89rz1bXYPB1YWdc5hMXnqyd63pUX/4
         y4jA==
X-Forwarded-Encrypted: i=1; AJvYcCVY3049xiTw298fYpoJTZCYT/9FNcHmwH1gGTguNblAxMjnE3d0THri+ca8v5z2n/Je3IBGhTQ6ES4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwT2IgX6QAB6OQRBEBDxXzsQ5VxORkdL6L7HFpfq7S7o1SEnC
	XJ1etFKyG5fayCdaWCEJB1k7V0Ib+q3p0M0w+SNLz6yh6CIM5ZOHwkfTYH5gMxpw0xZYrbI5HLS
	BZ+VNCwAuVLdF2vY/Eeb4Z3cWuCqLMy69FFiHO101eQ==
X-Gm-Gg: ASbGncusaUs1I3tkw3U6Jm4g53im3ANdyOz6QwULw2oVpNP3MqhJEGq/UGtGPh3YJyc
	J32hqSKVPpVUk/WLNbebWsNymHk1wo50g/RTFxsA8prxiLfCVkwY8JjU3GeEDuh2m3L0Q6PNTW1
	Q3q3cjOY+R4wXP5I5Prh2XDNS8QE7ECfpXbQKOTVguJGkLhw5jFoz7l9dp9dkFyZ3zaHBT04qne
	PEz2+kgpVqPRQwEBxYjDcXMUJfigC9KmcFAmbFW
X-Google-Smtp-Source: AGHT+IF9n3TPs24mXP/KjwmQUhHu+FJWEtosq1oYeVveVi3oASW8NolDlEZsKCpZBM4rHvLc1LSctNmuAv5MtuhmB68=
X-Received: by 2002:a05:6902:2011:b0:e94:e1e3:85fb with SMTP id
 3f1490d57ef6-e94f66442c8mr2236785276.52.1755672291534; Tue, 19 Aug 2025
 23:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755285161.git.jan.kiszka@siemens.com> <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
In-Reply-To: <8b4aeccbc005087ead1c261745877ccdb7dbb9d5.1755285161.git.jan.kiszka@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Aug 2025 09:44:15 +0300
X-Gm-Features: Ac12FXyD7fthuXlBjIwxGPCDwZnQfOaQn3pELvXYWoyyAX9kG_dNCA-jpkTCXA4
Message-ID: <CAC_iWjLzxfSXMAuQe87f4LE=yqQ60ddZ9WX94fagzbcepscLjw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi: stmm: Drop unneeded null pointer check
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Masahisa Kojima <masahisa.kojima@linaro.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jan

On Fri, 15 Aug 2025 at 22:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> The API documenation of setup_mm_hdr does not mention that dptr can be
> NULL, this is a local function, and no caller passes NULL. So drop the
> unneeded check.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> index bf992b42be70..ff41667b1005 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -191,8 +191,7 @@ static void *setup_mm_hdr(u8 **dptr, size_t *nr_pages, size_t payload_size,
>
>         var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
>         var_hdr->function = func;
> -       if (dptr)
> -               *dptr = comm_buf;
> +       *dptr = comm_buf;

I think this is ok, eventually tee_mm_communicate() will check for a
NULL ptr and return EFI_INVALID_PARAMETER;

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>         *ret = EFI_SUCCESS;
>
>         return var_hdr->data;
> --
> 2.43.0
>

