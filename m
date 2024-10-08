Return-Path: <linux-efi+bounces-1921-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9829943CB
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 11:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB90328CB14
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2024 09:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C451C1AC8;
	Tue,  8 Oct 2024 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIS5MROd"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEA318C34C;
	Tue,  8 Oct 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378689; cv=none; b=GlK/OWByY6aaNqY3fI8u6CW2z9o98sjHJdhrX8M9CIoOaLdoQb9/GFrylrshN/LQbbc/e4m6CHHEq5s5CCX8ZyyU7OfF0l0Ws8eEq4HzTi+e05PJGUFOyXSFO37fyIGHr4T7+0TGm7wv77LwGjxqSMEDnOFgaYTRTPArPCOk+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378689; c=relaxed/simple;
	bh=U/1/uJ/hBkxob7K3D4/ikcZe5ImlS6E7H73oK15LvJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMl7+timDsyJZR7WCXR5NnpbBlSwJmNT6QTVJDLudICFdq3+1YkPF521betLFfkPmKZGOJTyovBFEywIUAs9rpuUWUIkQ7QMqUdLQTZqmbdBT1MKs6iFA7RGdoBf7g5vHpdOy8zpzcr94TBxWdANEMjVob7dfCulv7J6190HSqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIS5MROd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1A6C4CED4;
	Tue,  8 Oct 2024 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728378685;
	bh=U/1/uJ/hBkxob7K3D4/ikcZe5ImlS6E7H73oK15LvJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZIS5MROdp2TLY8h52+w72tOsMXz0gVNdr9x6tLR2h0rIuCBhXGbKZY4+feqZEd31d
	 GbI6VNbJ2c+SwUcJOnrzn6VwveY+mtsOXh9kCJ+M/PTo3l7vbzHThZHLmc3I27xpkp
	 myExy8GaJ8qIqoquO/HSGUUfSFMVRZsHLQZqXWArNl42bAv7D2tB6ZxXuDefrUOWhc
	 Usb+UMfaJvniwiHflOGkdkHn2NZVsHuYJ8jRQGUQyJ1bY06jk48y3BKkiFMAMxGtab
	 2ziH8S/u//6ProS2v62vKO6wqmq0nz3aNmwJzQrTxQ7wh61+pcZt4vg4gyeWEv9Cs4
	 0npTNnboJ6bCw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso74715351fa.3;
        Tue, 08 Oct 2024 02:11:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURoI6OPcx4PXyzOpF2rYyOpXfNqKkz6bD2lCqlVOz7E1hplHUL6vmLJARr2OSjiII2m48F96ufezjP@vger.kernel.org, AJvYcCVwLALg66l8EU1+e7ZikcaNu07grSJDNUm6t48B+B1jqYef/AB1xdmQI0dMMUP8VD5QYCU+PCtHknpO@vger.kernel.org, AJvYcCXpb5zQX0A2Hy2OvIqg9xkBDn9NSKGJa+5twJae09ta7Ld3zG7/aymfvfQmhN8F2dezTZ+9S1+3udmcvaKa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UxmFlhXdvYecUvvSqWbRH13TsCV6mb39NXq5D7xayc/ih6Cy
	LKCm/j6sUjeJhTh2Pe7fU4zuQZfeHmZWRxYwPoefRkf8iHtLecOpvA1e//FxxI5wgD1xAdpDmgn
	kXalEvFbW7q2tVAwefCem4VaFX2c=
X-Google-Smtp-Source: AGHT+IHdWWFYOxSOwLZECHc8/8dZy7QOa19hjxZnQGDo2ySjdd2UKfbVudu2888peSyHtBneMfsbr05z2JJQ5NvLJXI=
X-Received: by 2002:a05:651c:505:b0:2fa:c0b5:ac8c with SMTP id
 38308e7fff4ca-2faf3c2977dmr98302401fa.21.1728378683775; Tue, 08 Oct 2024
 02:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006153611.1165482-1-kobak@nvidia.com> <20241006153611.1165482-2-kobak@nvidia.com>
 <406588af4aab38f4d746fe34291f4b853ca18452.camel@intel.com>
In-Reply-To: <406588af4aab38f4d746fe34291f4b853ca18452.camel@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 8 Oct 2024 11:11:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEuPaqNh++1NPu3+ch0wmhsrtESJjPRWvvuUsyBUwB9=Q@mail.gmail.com>
Message-ID: <CAMj1kXEuPaqNh++1NPu3+ch0wmhsrtESJjPRWvvuUsyBUwB9=Q@mail.gmail.com>
Subject: Re: [PATCH 2/2 V6] acpi/prmt: refactor acpi_platformrt_space_handler
 to drop gotos
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "mochs@nvidia.com" <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Ko, Koba" <kobak@nvidia.com>, 
	"ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 05:24, Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Sun, 2024-10-06 at 23:36 +0800, KobaK wrote:
> > From: koba ko <kobak@nvidia.com>
> >
> > Replace gotos with returns
> >
> > Signed-off-by: koba ko <kobak@nvidia.com>
>
> I think my previous comment was valid because a different prm_status is
> returned, say, PRM_HANDLER_ERROR.
>
> Given that we return AE_OK directly for PRM_HANDLER_ERROR case in patch
> 1/2, I think it is okay to drop this patch.
>


Agreed

