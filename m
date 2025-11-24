Return-Path: <linux-efi+bounces-5675-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8202C81CD0
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2537A4E8237
	for <lists+linux-efi@lfdr.de>; Mon, 24 Nov 2025 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F3DA59;
	Mon, 24 Nov 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im4OP44f"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0520B2BEC2D
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003891; cv=none; b=uKpaNTr1oNUZd/ACi+xr5GhkGvzJlAcDcfXE9Rd/MwtMsuM4CE3actY8yLO91ztEkYH4EJYBIsZbNBhv8NcgRF2tj5Z+4ZlFcsxsQyCoN82st1lSm3kUHHwa4PCMR+/c7STDTXW9DxGRCQsmL+tYViDqhUCJp83F/4NOjXTrv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003891; c=relaxed/simple;
	bh=ni6ryahXA4WhKdPgeajWMOfblZG+42XfxR7yeQeGziE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7w2neqdEUGz0CJCwUqidSQQWfi9/zG3JN0+j2XRbC32fgqPobwaaUnvhL5lKdp0Bj6F23feEwiIMURnr9y02w7KEi+dgJA790tmbfIHwlLh4z6JtSSgutNbTiwYKRBSrlG/7Q6PLVW71kdvOBJVzog9OZBk4E7wcDIGnlVCBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im4OP44f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCACEC2BC86
	for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003890;
	bh=ni6ryahXA4WhKdPgeajWMOfblZG+42XfxR7yeQeGziE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=im4OP44fxcV8oBiXqMZXwaFtVS4yC5hoDr6iH4M/56YLQZOOKaRle7OQov/Qnlgpc
	 pweOpV/Qx9+TaPNP1i64KV9t0z1kwKpRZHEl/J3XlJC+cR+wqtv3oO8T3HsjEmhsrU
	 ZtVBinn//9N8lupqgYuMpHVTmkr/1WpTaxJqeZFFs5ZzEB/cnxrzd6v+Cv9nfPUHID
	 p7UIXEGSLpaf/Q67sQEMT1wDqa7UVI7zjqvecNs5hfGGIYGz+6abqQqYBsgMSYc7qn
	 XhyxLD1u4+AfK9rfCUrFTgWqsCPefTxj02aekr97RvlQqXNTGyPfxQk2KneFbFI/b6
	 uJjshK0d7lslQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-596a055b1b8so4148553e87.0
        for <linux-efi@vger.kernel.org>; Mon, 24 Nov 2025 09:04:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDCaMPUnwnsDDMCOvKNrzyGxQ15U7YNu//wL11xbIDQjJawctTzao4G4ZCfAlI0dz8EuEC7w7274c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Bp17Zq8/tSgR7WWzblmY5+1SxFHx4X68MY+tP8zVdhOuWe/4
	bG71ZQFWbaeig/EBufMDjd9Z7J83wwyEnHIQ6UWcWUNjxtXwpxxzvTw/ghg+cjOCFxjvHOJdlgj
	K6yczguMqmPxDRJ8FosQW1W8raVfB+ZM=
X-Google-Smtp-Source: AGHT+IGGU4X2n28nXl03AZEGYJ2qP+YdFmcNyxyi9o9xFWaX9qXe+5YYYmW9XiGzz0iE7mMdFpmgf1MgItGyyi+uahA=
X-Received: by 2002:a05:6512:1282:b0:594:4c90:8415 with SMTP id
 2adb3069b0e04-596a3edab39mr4528817e87.27.1764003889213; Mon, 24 Nov 2025
 09:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124165116.502813-1-tzimmermann@suse.de> <20251124165116.502813-9-tzimmermann@suse.de>
 <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
In-Reply-To: <CAMj1kXFu4=L=ROVAaRORG5HMmYWHb6OXQf6pJ3yAZpeDmfmSeg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 24 Nov 2025 18:04:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
X-Gm-Features: AWmQ_bkKMcK7WGWFCCrQ1b9TEIPkREY9pqhPyguPzmrEL1z0shGOixam-7jvNpI
Message-ID: <CAMj1kXFtsneE3dFgUx6Hd=iBhD8YpvjfTSi-KZpuNaXfX07KyA@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] efi: Support EDID information
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, arnd@arndb.de, richard.lyu@suse.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 18:01, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 24 Nov 2025 at 17:52, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Add LINUX_EFI_PRIMARY_DISPLAY_TABLE_GUID to the list of config-table
> > UUIDs. Read sysfb_primary_display from the entry. The UUID has been
> > generated with uuidgen.
> >
> > Still support LINUX_EFI_SCREEN_INFO_TABLE_GUID as fallback in case an
> > older boot loader invokes the kernel.
> >
> > If CONFIG_FIRMWARE_EDID=n, EDID information is disabled.
> >
> > Make the Kconfig symbol CONFIG_FIRMWARE_EDID available with EFI. Setting
> > the value to 'n' disables EDID support.
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> Why are we adding a new config table again?
>
>

Note that LINUX_EFI_SCREEN_INFO_TABLE_GUID is internal ABI only
between the EFI stub and the core kernel.

