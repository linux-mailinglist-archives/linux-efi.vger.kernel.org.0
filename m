Return-Path: <linux-efi+bounces-1366-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A98924178
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2024 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656541F21F86
	for <lists+linux-efi@lfdr.de>; Tue,  2 Jul 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412D1BA89D;
	Tue,  2 Jul 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbxW6LU5"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF3E1BA892;
	Tue,  2 Jul 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932070; cv=none; b=Y26RK/3QjKLfVB6IY2Dos1DxIg6s+PaPuLug7uvhV6Q1rffQ1j6/TDoxwLoLTZWvhWZBaB8VBXKI0oWB+zwA1/2zUDdBi/Bf5mCZP1NxNUmvb4OXG8+MPoT9GbqjrG3Ph9Hi5gtxZ184WTJGF0RMN65uSeHC7mUJU5bjCTIFEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932070; c=relaxed/simple;
	bh=TaI+nB0ZJGeSrYMleXJBRusDkseeq1JKf+GsAnw96SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COLGd7FdaSJlK6Ti0//jLo28tR6erkhIjke6kSgno/2q1H8FXnPlFyTwd+aRmy+MRAhbn49BG+MXyDpIaEbGb5pvSlJl/mr47873AIIIOZ3zobU5LB3CvcSqB2w88Y1mCXBBm+aPzUjicJRD5fsATYTpRk2NLlrJak4JIDuxj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbxW6LU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7CBC4AF0C;
	Tue,  2 Jul 2024 14:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932069;
	bh=TaI+nB0ZJGeSrYMleXJBRusDkseeq1JKf+GsAnw96SU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tbxW6LU5ep5erzNL3EiwJb+I50M0eCWr/UImQXOVTgGMJtJgHDPRC2MfuK07nS0xH
	 eeVGsFvai1Zvii6pfTYF1VtduyU2jqSNxcqnqeKsWO4lgbYijb++YuaxLG+WFGu3ET
	 8A7l9Ap8Il3oNDN4scdS5i5Q593Cbs3u8tDedWkYBDYVqw5hi+sB+QAD0S2pcF1ZHd
	 ixUm8vwNEcREa2VT8zU15+oFFvj/EW5f3HqBwj1jluIUctY7kh2j61jSA+zqnNIfic
	 KceDooX7q1j/9aqszl4kbzxx5E/c/ayWQ1citKeVtCuT+kmgoKhHNuxI1m17dzXbJT
	 Q+Q5cn/tUZXVQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so10538291fa.3;
        Tue, 02 Jul 2024 07:54:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWSwLSneNtf8RBJuYQU5z58asbqapyeWwZLpPMVyURDdrW4xKeiZRRXEpsI36rml/k1/c8pnc+8tYM4khx5YffDvQZFtJI5HvHcX7WsY9mM5MOBXXfjk0ePIhkk/aJcKDM4UrwYu0DQ+KTUerYQouYZmTxPbrUgrbk1UcPVB1GsibiLRXQwV93OxftsFejO57goQwWmjx4DBwD1jvHoao=
X-Gm-Message-State: AOJu0YxE02DI9gI3Ea9lM3buFJK3N/jhRivN1wgHUe8+tFfa+7h/n/Si
	RuR8lzB5gBFZCdXlA1fmH7/eMW2bcaTbuxyEvA39ywN4VY34faYRqO7I3WjD+W8lxhyQ+NXB/Kp
	yDwl5ac5dYscH2HOskBdL7/Ps/J0=
X-Google-Smtp-Source: AGHT+IHb3CV0ugaADa64FK+5hltnQPwSgB/QJrId5Rv7Zs0zSjmG+9VdS1AjRSt9LsoPkH80k6BYiK1TmI/EB8+bIx4=
X-Received: by 2002:a05:651c:b14:b0:2ec:5488:cc9e with SMTP id
 38308e7fff4ca-2ee5e3bbd14mr72964281fa.26.1719932068120; Tue, 02 Jul 2024
 07:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506174721.72018-1-john.allen@amd.com> <20240506174721.72018-2-john.allen@amd.com>
 <20240627080801.GDZn0d4Sr9y0B6zvPh@fat_crate.local>
In-Reply-To: <20240627080801.GDZn0d4Sr9y0B6zvPh@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 2 Jul 2024 16:54:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF534YBft=a9X=RwBthEuPb4j7usQ+F-j2PHCjFhmeZxg@mail.gmail.com>
Message-ID: <CAMj1kXF534YBft=a9X=RwBthEuPb4j7usQ+F-j2PHCjFhmeZxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: PRM: Add PRM handler direct call support
To: Borislav Petkov <bp@alien8.de>
Cc: John Allen <john.allen@amd.com>, linux-efi <linux-efi@vger.kernel.org>, rafael@kernel.org, 
	lenb@kernel.org, yazen.ghannam@amd.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Jun 2024 at 10:08, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, May 06, 2024 at 05:47:20PM +0000, John Allen wrote:
> > Platform Runtime Mechanism (PRM) handlers can be invoked from either the
> > AML interpreter or directly by an OS driver. Implement the direct call
> > method.
> >
> > Export the symbol as this will be used by modules such as the AMD
> > Address Translation Library and likely others in the future.
> >
> > Signed-off-by: John Allen <john.allen@amd.com>
> > Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> > v2:
> >   - Align statements setting fields in context buffer on '='
> > ---
> >  drivers/acpi/prmt.c  | 24 ++++++++++++++++++++++++
> >  include/linux/prmt.h |  5 +++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index c78453c74ef5..1cfaa5957ac4 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -214,6 +214,30 @@ static struct prm_handler_info *find_prm_handler(const guid_t *guid)
> >  #define UPDATE_LOCK_ALREADY_HELD     4
> >  #define UPDATE_UNLOCK_WITHOUT_LOCK   5
> >
> > +int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer)
> > +{
> > +     struct prm_handler_info *handler = find_prm_handler(&handler_guid);
> > +     struct prm_module_info *module = find_prm_module(&handler_guid);
> > +     struct prm_context_buffer context;
> > +     efi_status_t status;
> > +
> > +     if (!module || !handler)
> > +             return -ENODEV;
> > +
> > +     memset(&context, 0, sizeof(context));
> > +     ACPI_COPY_NAMESEG(context.signature, "PRMC");
> > +     context.identifier         = handler->guid;
> > +     context.static_data_buffer = handler->static_data_buffer_addr;
> > +     context.mmio_ranges        = module->mmio_info;
> > +
> > +     status = efi_call_acpi_prm_handler(handler->handler_addr,
> > +                                        (u64)param_buffer,
> > +                                        &context);
> > +
> > +     return efi_status_to_err(status);
> > +}
>
> + linux-efi as Rafael wanted to make sure the environment is created properly
> for the EFI runtime services call...
>

This looks fine to me.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

