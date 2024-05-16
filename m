Return-Path: <linux-efi+bounces-1047-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2868C7CA3
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 20:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D72829C5
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 18:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CDB156F38;
	Thu, 16 May 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVXTlHEp"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A7314533D;
	Thu, 16 May 2024 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885261; cv=none; b=UOyvAbvdc/AcZt8cIARwutCYF6sBMLE9sP7gdtRnMZmkeOzer0X4TfC7Y3qh4KHeloz0xICMV5FmIEevyKOnCyVSVyvbKw7aDcmMuTV7C4Pfjhg+4LENZs3RAJ4M7cf63f6TtvTAmNDHNCn4G0hVDkjw8WLgIXxa2EEGJmVZP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885261; c=relaxed/simple;
	bh=jm+jW7lXzqC7OUQoWU9fKu4kPcG7Y8Ley+euTkWLiUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUfyKCjocP2Gb9t2apkE/4JerPTEcZCjq5VzYdQFuQzvhUj1W39VrTtecjJq2Jg54GjtIFrd19UaOCEF0RD+cmGGejjX/pr7XKU6mx9cAnZ4WaWoYyjtw3UgtdLIFwlN9hfwQmCVN284+m/zlRw4bCesI2PuD+BPHvs3IqOJ1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVXTlHEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFA0C32786;
	Thu, 16 May 2024 18:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715885261;
	bh=jm+jW7lXzqC7OUQoWU9fKu4kPcG7Y8Ley+euTkWLiUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gVXTlHEp+++5rSNwyJMr118cGmOOnB+Jxn4WluPQSdvjVzMNLTY5dWB7cnfkdm3kR
	 XGw487Yb9CEsLvYBWHjqiWhW+QfNhyuVm2c7rEuPlKnFT2bNTRBtBjFpdAgXFlcvQN
	 Lv//0Sj9cYWvrg+blKTxqgwEbwtDcLDImXiH0klDWvMHI6G2e5GmxQKiCFy8SNJubs
	 0g6z/0gX97SyIVvN+HLAhQFwLdRIPS/qQRz95lhgL4h2+PM4gPL9Lrgp4TcGCHOo0N
	 ngGrF6tit5Ezm42NFIljZxmC4qDtTAhCgS8+kJ3GWcIYqvdeDLBT5mgsmYiRhY1g0k
	 erUqLPyVFY3rA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6ffe57c23so11131601fa.3;
        Thu, 16 May 2024 11:47:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUipu1P4fWbLXNbvfjRg/aQlZQM52duKCfB6cyIfUZEU8pWfGN+A2rGCf0a5wKEQe3w4xOuk+o0SiX86J1o850T5jVNn1NB9jf3BmDbkWVqMxeGvA4o22j6ERlvMw/203zCFtOlGcFZUnAABJgp4qqf2XXBGlbTObjMM0wKbpKW
X-Gm-Message-State: AOJu0YwvDwoVw/UEfk7LFl5xzwmIMJpPm+C6zYFlxBNBZDtD85mgbFWR
	7zqCw5fEiDp1HoBtV9lh76kj822agdQm58gddSPQNqJkUsKiUgSwx2rGgt6jwC2MU/iC7Dmv8Cd
	v/tQONcR1mvHBnorjUWaxYmBIbZk=
X-Google-Smtp-Source: AGHT+IGGnSrHI5R5guYtSC89176WLUK0K1h/xOskDaV0ddYq2dgBIztvzDAgzA/gFxwQ6NHEh6DiUyOjvWGadVsTw7o=
X-Received: by 2002:a2e:9650:0:b0:2e1:d747:8c0 with SMTP id
 38308e7fff4ca-2e51fe54086mr156416451fa.21.1715885259339; Thu, 16 May 2024
 11:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516090541.4164270-2-ardb+git@google.com> <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
 <202405161142.A62A23A9@keescook>
In-Reply-To: <202405161142.A62A23A9@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 May 2024 20:47:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEAqKTaXD8o3bM=1u3COG=CYUp7P83L6segM4dKYoDszg@mail.gmail.com>
Message-ID: <CAMj1kXEAqKTaXD8o3bM=1u3COG=CYUp7P83L6segM4dKYoDszg@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory reservations exist
To: Kees Cook <keescook@chromium.org>
Cc: "Chaney, Ben" <bchaney@akamai.com>, Ard Biesheuvel <ardb+git@google.com>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 20:45, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, May 16, 2024 at 05:29:11PM +0000, Chaney, Ben wrote:
> > > +static efi_status_t parse_options(const char *cmdline)
> > > +{
> > > + static const char opts[][14] = {
> > > + "mem=", "memmap=", "efi_fake_mem=", "hugepages="
> > > + };
> > > +
> >
> > I think we probably want to include both crashkernel and pstore as arguments that can disable this randomization.
>
> The carve-outs that pstore uses should already appear in the physical
> memory mapping that EFI has. (i.e. those things get listed in e820 as
> non-RAM, etc)
>
> I don't know anything about crashkernel, but if we really do have a lot
> of these, we likely need to find a way to express them to EFI...
>

Perhaps. But the fact that the current KASLR code ignores it entirely
suggests that this has not been a problem up to this point.

