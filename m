Return-Path: <linux-efi+bounces-865-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310E8878AD
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 13:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646151C227A4
	for <lists+linux-efi@lfdr.de>; Sat, 23 Mar 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAA21370;
	Sat, 23 Mar 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNOXMR9W"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BBCA6F;
	Sat, 23 Mar 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711197605; cv=none; b=Mkywwto2zkJ+jErmO6eS/ecxZO/i/AoxryuoSgjTT2YZ0YXR1QFh0ZiZGNmsiC6zsTctArCOmLimQHEoY2P7PltNrwP0aNTb+2PlwZtvWN7dbGsKkpEuN8TKPuEDPAWIZ5qwrzMceh9BlUj+D4IwybZtkewRXxnDTLsNxQ47qJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711197605; c=relaxed/simple;
	bh=cbSZolRDzHHEJXXy+xiONqpLt3MC8VuAdPFXF38KDkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alIdw9PrhmrlgeP+GKyaZohgvWmqWTqHjYKYpRCkDeM8sO2LgVgGGfoR9BLXjmfAAf5738PbMeS/nDz79ubOkT5UoaC1/6+uTzcHpUOFfmxXfT3QnwnIR3OLdsmbBqQnSRnvM9t6DjIQ62r4djCkP/nRr76Wyi4eYeqPrbos+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNOXMR9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C217C43399;
	Sat, 23 Mar 2024 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711197605;
	bh=cbSZolRDzHHEJXXy+xiONqpLt3MC8VuAdPFXF38KDkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lNOXMR9WCZz1sx4YPMuxBR4aCsOYTQoGLWRdvInLWitHiKWJmADDfu7UgNKcdmolB
	 bRPBPEMov9gMUpgXZ2GqrdeAy6rfyuQgCvhhR5J6zKXm8i1tDlAWkajoShtiv9cePP
	 znZLByFqd+JlcM3q45TkKJI7iNAN7hh2GS12uO/Atgg4xUjxR+QC9P+DinDeZFBeZK
	 QUjIdZrh1RtEabIY+qxh5F7jC3WtUbySjZAJPWkXxnmdiV5OX3UMbsuC3u5i4CEADt
	 zDFrh/VDcMd9tE74JNUMg345+gY4e6HuaIp9xVoNPOCo8gBofJq4aAbjZtMCAfIBVm
	 d75l4ueuSW4Ig==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d68651e253so50570571fa.0;
        Sat, 23 Mar 2024 05:40:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUePTZ+5DLhBi93kCTA8wM+lsXPY5YyZuS1vvVlm3FNLcJvN7iYJGNVk8Js972mH2BVSdPzoSw+kBxGa1x8qPIbnidcf3bwB08wR5pR05DXAsJr8uZH/vMSRm8C9CPJiNP/ooQI1VVb
X-Gm-Message-State: AOJu0Yyv3O6zD+ykQ1vBYsl8dREnIht2PLMcpAHQCQsFlgHEXY+lAEmq
	Tr8k7UR0+GgOdQZ1NeFZIrbIYKN0VicX3VzJ3Z4dWy1nOSixJLWYujaetkLBNy+G7at1q5N/R4N
	9SGsaSg0Fa9ILGYJ6+8+hTHJG2AM=
X-Google-Smtp-Source: AGHT+IEJvtbme/eS1L6D9RG94EKx6mhtYiagbSFm78FWvwIqq+NA3C7kvVkTUtUFsPi+e1xNkbGDEo6a9nBFejMQlu4=
X-Received: by 2002:a2e:3615:0:b0:2d4:3b15:5561 with SMTP id
 d21-20020a2e3615000000b002d43b155561mr1366070lja.40.1711197603491; Sat, 23
 Mar 2024 05:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321150510.GI8211@craftyguy.net> <CAMj1kXGzH4TiwvSF3bZsJpuuWf04Ri_852fUMTdH8pLRaH3+Yg@mail.gmail.com>
 <20240321170641.GK8211@craftyguy.net> <CAMj1kXE-sxGM2H8akunJ1mZPDSVX1+2ehDtK-jqW--8tw9J5LA@mail.gmail.com>
 <20240322091857.GM8211@craftyguy.net> <CAMj1kXFmnv+FGRMnnJMJejj5yvSybgZTNEYZz0hxb6K9VAeo1Q@mail.gmail.com>
 <fe09869c2d853bde8ce0feb537c4dab09014f5d9@craftyguy.net> <CAMj1kXEH4CTnQ3d+Z-TnqNUhFaFc1yH+Eaa6cHk9-vZ_geQ2nw@mail.gmail.com>
 <8a64ba697d719bc9750e6fffc268e194dfde16e5@craftyguy.net>
In-Reply-To: <8a64ba697d719bc9750e6fffc268e194dfde16e5@craftyguy.net>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 23 Mar 2024 14:39:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEk=7_BoaavZtZs7giBq4Kwk-QQoNjMZS=rWLJP=LdVLw@mail.gmail.com>
Message-ID: <CAMj1kXEk=7_BoaavZtZs7giBq4Kwk-QQoNjMZS=rWLJP=LdVLw@mail.gmail.com>
Subject: Re: x86_64 32-bit EFI mixed mode boot broken
To: Clayton Craft <clayton@craftyguy.net>
Cc: Hans de Goede <hdegoede@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 21:34, Clayton Craft <clayton@craftyguy.net> wrote:
>
> March 22, 2024 at 11:30 AM, "Ard Biesheuvel" <ardb@kernel.org> wrote:
>
>
> >
> > On Fri, 22 Mar 2024 at 19:57, Clayton Craft <clayton@craftyguy.net> wrote:
> >
> > I have pushed a branch below that reverts the patch you identified in
> >
> > 4 separate steps. Could you please check which step makes your system
> >
> > boot again?
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton
> >
>
> Thanks a lot for doing this, I really appreciate the help!
>
> It looks like if I build from 868a7245, booting breaks again on my Bay Trail systems. If I put back 00e85ab5, they boot again.
>

OK.

I have reshuffled the branch and put the patch you identified as the
one fixing the boot first. Please double check whether this change
still fixes the boot for you.

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=efi-clayton-2

If so, we can try applying it to mainline, and merge it if it works there too.

If not, we will need better debugging to figure out what the hell is going on.

