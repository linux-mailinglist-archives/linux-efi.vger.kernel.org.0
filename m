Return-Path: <linux-efi+bounces-2642-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDAA12744
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 16:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9421694B1
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2025 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FAD14D6FD;
	Wed, 15 Jan 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqvMva0N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0824A7DF;
	Wed, 15 Jan 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954500; cv=none; b=iTyZWJwsU502f0Gux3If/GzB1WsXZMK61e7uqf4dVRs6vyNIa8NGhhlbHe9A2lEwTwpG8BUnC59gUHmBKwfALoQXmU+Yd1EnvQmYPbJLrlBUa1nGm42H/MFdpWWM94XtQUWYbnqZu0es/AhJ1Pgfag6rwHCAkByzPtTRYLMJvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954500; c=relaxed/simple;
	bh=1+ncL9URgbFQdwJWiF8V7QeiIDMloijaOKhCHcLsWeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGE1GESGELj95swY/JuffwvWNESTqRm0pq40TfgtM42qWygZiglcZXSKJVpjC+tBjoNq5xrKFjEofrFesSLKzwMv94ujEAeBQAhfPDBGxiiWo+qWVAIMv9cwOYH3JjOBCk+UnT8tSQww8OaQly+oH6e50sAEpfs+qp5fwxXOC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqvMva0N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21619108a6bso122796825ad.3;
        Wed, 15 Jan 2025 07:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736954498; x=1737559298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d52YOW9sOh20aA9jZuD1svmWjqBXi3Z30H6i0ailAec=;
        b=WqvMva0NIAad9GpTrwOLuBi5fhHuctooGYVLC60Gfoxhk9b6tD7mkO2EK7qavS0NLu
         by8D52p312XOLROMa9WjNU7/WPF5SGyHBc/xnJrH3uLX7SXTmr2AcvYszDEfhplL5e7C
         GTAg4Jw5b6ZfItcqGg6iI+/bd6IrU7R+CtLzbuTC7NThIFDlCRlYkMDxRUG2OKgJaHlM
         uDsZMrYuAvYl5a6Z0RuX8aohuLCKJdIfcDO3fvcY8BEeuZS95rehBSqEX94Uxcl5QZuo
         gc032EH0vewRWICXUtQlXsmUBJh5FVHYSlRDAz8OmLrV+H9F7TbB35v6DKrOxvxG9qoH
         xcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954498; x=1737559298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d52YOW9sOh20aA9jZuD1svmWjqBXi3Z30H6i0ailAec=;
        b=nOGdaYKiC38ao6zo6HZWXNVlLQ++oO7AclMU0AEh5abvB1BEGO07HvQixblL+URZwV
         T+ZLx11QtNJR9Vz7yuusQ/mtgNcyC/V8ezBOy+4b9mfXudKMZZ1kzWECj8qWKScvoVZk
         oRgphqk09vzQGYkLIatHaciXFjY7j8Vr2PN28jzplH6Ii+MJN++nJPUViug3F83DwTLn
         6hYoHmXB7GL2QLwX6NJ6ynttUzTLG2JE6DiYjXWWPBu2Fr9R+jcTDlJ9kgW2g6TkKle5
         D3dpZg+W4rRthJud+4W/9oj7TvTI+u+o/7HhuRBdEW2K5PW7P2Y6k2z0sv4YmCh+DW59
         z/hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9dvVX0NmV6gGrucW0h7HFISI1fOwLYBl/FbSjCJyhUaylK1zIcLoz9C4L73bAfwzH28Pgxph8niy76mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8xa4H+QpIzYIjYYr3uuWR3onbV7ww5glW0vyHvDVwW7zP3zcb
	nAyrMUj2nVLTUhYRzBa1WACbmx9BbMTOPSnx90zxGywjAmol9URl
X-Gm-Gg: ASbGncugX8Dsuj0IPgh1J+7gNEL3RBxuyI49sV96yVihRS+OWdOcDMaSuLr1DWIWyzc
	8V+UC8CWEEnnmkassECV9l8wZh9cLD2lSdLGp05R4pR0wuIgqTJ9AgZz3K9HPv+9QL8XAkbcutU
	yiOCxY83EK90ahXpzD0GkuwSi4IHO0zAE3Mo7Jb1cwZ7lloWYMbz/jSglQbh0W2lozmLATbdtSF
	+DsFwRJME+MaDHmkzpHLNMOI2HmsmISHpMDKgT5Mg2rbGKTCSsR+ns/904=
X-Google-Smtp-Source: AGHT+IFjVulVw8qU/w5ibu0ZE17wAK0QBJEH0Pmz1jZGIyxvU7b57xnW3V+F3QTwTG5WV77UxyygLg==
X-Received: by 2002:a17:902:f60e:b0:215:522d:72d6 with SMTP id d9443c01a7336-21a83fd2383mr454464255ad.38.1736954496997;
        Wed, 15 Jan 2025 07:21:36 -0800 (PST)
Received: from eleanor-wkdl ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e0dfsm84189915ad.41.2025.01.15.07.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:21:36 -0800 (PST)
Date: Wed, 15 Jan 2025 23:21:32 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] efi: sysfb_efi: guard EFI-specific code with CONFIG_EFI
Message-ID: <Z4fSfE6mFk1nT9e4@eleanor-wkdl>
References: <20250115141650.3658827-1-eleanor15x@gmail.com>
 <CAMj1kXFGrTQHONPCJMvMJ5aaswh1YF9aCcufS_9YsS5F+uYJpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGrTQHONPCJMvMJ5aaswh1YF9aCcufS_9YsS5F+uYJpQ@mail.gmail.com>

On Wed, Jan 15, 2025 at 03:46:46PM +0100, Ard Biesheuvel wrote:
> On Wed, 15 Jan 2025 at 15:17, Yu-Chun Lin <eleanor15x@gmail.com> wrote:
> >
> > As reported by the kernel test robot, the following warnings occur:
> >
> > >> drivers/firmware/efi/sysfb_efi.c:331:39: warning: 'efifb_fwnode_ops' defined but not used [-Wunused-const-variable=]
> >      331 | static const struct fwnode_operations efifb_fwnode_ops = {
> >          |                                       ^~~~~~~~~~~~~~~~
> > >> drivers/firmware/efi/sysfb_efi.c:240:35: warning: 'efifb_dmi_swap_width_height' defined but not used [-Wunused-const-variable=]
> >      240 | static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
> >          |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >> drivers/firmware/efi/sysfb_efi.c:190:35: warning: 'efifb_dmi_system_table' defined but not used [-Wunused-const-variable=]
> >      190 | static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
> >          |                                   ^~~~~~~~~~~~~~~~~~~~~~
> >
> > Unused variables, functions, and macro are conditionally compiled under
> > CONFIG_EFI. This includes 'efifb_fwnode_ops',
> > 'efifb_dmi_swap_width_height[]', 'efifb_dmi_system_table[]',
> > 'efifb_add_links', 'find_pci_overlap_node','efifb_set_system',
> > 'efifb_overlaps_pci_range', and the 'EFIFB_DMI_SYSTEM_ID' macro.
> >
> > Suppress unused symbol warnings and ensure inclusion only in relevant
> > configurations.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501051626.SMkizYIE-lkp@intel.com/
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > ---
> >  drivers/firmware/efi/sysfb_efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> Is your patch better than the one already in linux-next?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=19fdc68aa7b90b1
>
No, Randy's patch is better because it also addresses the additional
unused warning. Please ignore this patch.
Thank you.

Yu-Chun
> > diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> > index cc807ed35aed..4efe383cc470 100644
> > --- a/drivers/firmware/efi/sysfb_efi.c
> > +++ b/drivers/firmware/efi/sysfb_efi.c
> > @@ -174,6 +174,7 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
> >         return 1;
> >  }
> >
> > +#ifdef CONFIG_EFI
> >  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)              \
> >         {                                                       \
> >                 efifb_set_system,                               \
> > @@ -346,7 +347,6 @@ static const struct fwnode_operations efifb_fwnode_ops = {
> >         .add_links = efifb_add_links,
> >  };
> >
> > -#ifdef CONFIG_EFI
> >  static struct fwnode_handle efifb_fwnode;
> >
> >  __init void sysfb_apply_efi_quirks(void)
> > --
> > 2.43.0
> >

