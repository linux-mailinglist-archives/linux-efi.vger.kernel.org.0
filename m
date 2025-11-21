Return-Path: <linux-efi+bounces-5639-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF5C7A82B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 16:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2984D3A318B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Nov 2025 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC401350A3D;
	Fri, 21 Nov 2025 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZZ1uHWX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5E350D60
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738194; cv=none; b=qHtwbDkFEXkXMbLcMZzbj6IyrfVJgU2x6gO9MKAZU2Pma0WWt54A1cyUGvEh61eHv78ooq4JmfvWTqaZUjX3GrI5gNvr6+Fclb7VXphUaWZ23l+F/a6vyOKuwxEFDU1gFO40MI2lmRygZTO0AiIwXhaMvL3lSEVcqNInVI1tpEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738194; c=relaxed/simple;
	bh=4Nw5kzDQ9aadF93520L+loYg4Pe3c7ohExj2x9LkHTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFG22uAeyG4o/mAsTRWGJ8UIWIg+Gm1ylvvxI4QbtiCN41NJ6wuGYUu30hWQ8HDnj25OXW8GkJx7aCQqDwqcbTme+5xTWn8BGCZsmlJSCpfcK0QBfvycqAOPs9ADRcjlnJpqjFYieHctF9izLgshPls9fAykU5t0yqwXJU3OtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZZ1uHWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C60FC19423
	for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763738193;
	bh=4Nw5kzDQ9aadF93520L+loYg4Pe3c7ohExj2x9LkHTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YZZ1uHWX8jA8h3KqeGr5dk5BqSVqo2ZxZUdgIweTw8ldAfF2BlKGbx9hcCetumLYF
	 6Z0Av4erPZ1ceu78hk33NVgzoft53GdBcDHrjLQI208QVTibCUAnQCXJr7dFEKOJzp
	 vgyagzRm0Pw7hrUcJLqFULp4DiiDbA7fgHa7kGVIyYElH9FO0ZKbsfr0lXWeW/Etan
	 9UrtWfJtqyHR0CmqDBUR48vIDrb0Baro3f00cbZ9KAHq7CW2noZ8PM+tJ3/z8URu75
	 6Z9cxuWlBxzHnFoYSYDYrRggRq5Y9axSC4q01vXWPQt8uMMkjzBr553v5fFmpzGmGb
	 +QnmP3qW8lTuw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5957d7e0bf3so3012691e87.0
        for <linux-efi@vger.kernel.org>; Fri, 21 Nov 2025 07:16:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7/bmEp70iqyJo3fckrdTWK3/EbHP4QIrnr1L0ajJDtani6EjL3IM14l71clkW8GWHv/gsxEThDh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmbojmfJboaJZ/2tgf0HevruqMVEWF6NimQj7dwyyxMhkffjv
	k5fNtZEzg9N+hJdGZiXQGxssZiQbMBuaxtq0IidFBvOqpXoNuHYx185xQaSdCfll35XneKTVaI1
	Y1hGakSacah7SeBtsuo1UQlZqJ8h6TiQ=
X-Google-Smtp-Source: AGHT+IGPowCSKA7rqmBuuVeVvwKvJAgVwSGnoB8Wq+tDig5gUYW9uVP5SF2rLUXJXBy7GBEfdZMPDjZn9AIuPMCXlv4=
X-Received: by 2002:a05:6512:15a6:b0:594:5f1d:d60d with SMTP id
 2adb3069b0e04-596a377e72dmr1012107e87.14.1763738191788; Fri, 21 Nov 2025
 07:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121135624.494768-1-tzimmermann@suse.de> <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
In-Reply-To: <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Nov 2025 16:16:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com>
X-Gm-Features: AWmQ_bl_zPBWf1NywIhUPQAGEMUCFj4H1ZabIpySRf4mYN0qS7e_KlhM-cPxo4Y
Message-ID: <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com>
Subject: Re: [PATCH 0/6] arch,sysfb: Move screen and edid info into single place
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> > Replace screen_info and edid_info with sysfb_primary_device of type
> > struct sysfb_display_info. Update all users.
> >
> > Sysfb DRM drivers currently fetch the global edid_info directly, when
> > they should get that information together with the screen_info from their
> > device. Wrapping screen_info and edid_info in sysfb_primary_display and
> > passing this to drivers enables this.
> >
> > Replacing both with sysfb_primary_display has been motivate by the EFI
> > stub. EFI wants to transfer EDID via config table in a single entry.
> > Using struct sysfb_display_info this will become easily possible. Hence
> > accept some churn in architecture code for the long-term improvements.
>
> This all looks good to me,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> It should also bring us one step closer to eventually
> disconnecting the x86 boot ABI from the kernel-internal
> sysfb_primary_display.
>

Agreed

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I can take patches 1-2 right away, if that helps during the next cycle.

