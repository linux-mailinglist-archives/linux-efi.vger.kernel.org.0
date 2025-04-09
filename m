Return-Path: <linux-efi+bounces-3246-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DE1A81C9C
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 08:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E071B648D6
	for <lists+linux-efi@lfdr.de>; Wed,  9 Apr 2025 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70281AA786;
	Wed,  9 Apr 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2q5XJXf"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21D3E47B;
	Wed,  9 Apr 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178833; cv=none; b=pdZU0ibXnSFDN5w4neFGBhzn9ctpic/jrRsj5WzaPAsrEpZLpX4naOOBJHqCul9wycpTlICe6cFxhvp4sVdNUx2+YH7GruJz0hgCiGWbPXpBU44OirMwfaMXqvY1US74qj7G1Q8zYHpDwDCl4+O2JTSfgPjWjSy9Ja7CMNs4mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178833; c=relaxed/simple;
	bh=4VLTyB/y7fkkvfWGsIq6TQQScgFpmsOfPSy/CVaTpCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFSmljzw37+4Z+13IZo1fs4WsAbNl6Q4Qql/Z43VVMlT6XfTXpMVb0wln/L8XzsaUPZ+fcb9yd4u6K4IrIA7TcLCRzpxQe0KwBiiKghQkUCt9bzo7AETj8KbWJnVNjr8Munwgf3mWokLbyFdRP9VWxEDZZ1KNt4vWOycCyLqiLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2q5XJXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA5C4CEEC;
	Wed,  9 Apr 2025 06:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744178833;
	bh=4VLTyB/y7fkkvfWGsIq6TQQScgFpmsOfPSy/CVaTpCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a2q5XJXfXzgTGzQ8rtqXQ1wfl6bje9XAyaitY8ebevgyyCjtgTGemzOD5EGsMdk/5
	 /etVDMjxsiBPkqae7KZF27vcnMrqkOOWgp2Gku1rAPHAEkNCJ+OBWPTLfDN9VMyBzA
	 pYcWavr95wg9TsqOdMWX7qXu3yvoCNLobbdszV+sOX0+SqVJw4vQgXGcGM7jt4JZt1
	 5EGcwNbqLIcRQ64iFIk3/tzAJIhpWV1EWK7xpgzkmRFMU6NgapGWH+n59hH6na/l1Z
	 vgy6GTNQtqOW51NwWmGRZvIRl/rx4LzsryiMLl82BwzJJ8RSQO6PkAUsqUzf32SKjE
	 BuV03CWUvwsVQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54af20849bbso4001362e87.0;
        Tue, 08 Apr 2025 23:07:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsRGqYmS9BASXTo/gP688j364yH9+Cgx2RROoS0WxTOoJAyY+xsPZXxAtqIF9JutwEf+0D8qzrd+P/vuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kwagRYKBYsS+OnlCwWoVyiyRay6SyAzSHyfH11bnsqPk4g0n
	zfOKvFZvYwAo78oVY8+B85SkR/MTuWSUrM3oT2xZzMM4+ufxq1anNrJjp0P16TNL4ik/jSTRcxv
	SXCLL479i/ldoQa+0QlIhZV1Hz94=
X-Google-Smtp-Source: AGHT+IHUuvqmuMZmnHu1Ea/lodHpPFpjpt+v62cdN4A0tXOT10coLDa6MCZKyZGwcCNGxLXdn6hM6+Ii6OY8YLXa/eQ=
X-Received: by 2002:a05:6512:23a8:b0:545:743:cf44 with SMTP id
 2adb3069b0e04-54c444b33d5mr349808e87.12.1744178831493; Tue, 08 Apr 2025
 23:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB6129DE70566C6FB5E73400C7B9B42@SJ1PR11MB6129.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6129DE70566C6FB5E73400C7B9B42@SJ1PR11MB6129.namprd11.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Apr 2025 08:06:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEfBMczOmA2+dMMubuD-qE59GTAiV2E_9m8KNG4-rgP6Q@mail.gmail.com>
X-Gm-Features: ATxdqUGtqKqQkXZ_e2kA5a79FnqkuCOGA_SinGq6AWPbToN1IRaLDpSKB9AOnVc
Message-ID: <CAMj1kXEfBMczOmA2+dMMubuD-qE59GTAiV2E_9m8KNG4-rgP6Q@mail.gmail.com>
Subject: Re: Build Failure on linux-next (next-20250407)
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, 
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>, "Saarinen, Jani" <jani.saarinen@intel.com>, 
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>, 
	"De Marchi, Lucas" <lucas.demarchi@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 07:01, Borah, Chaitanya Kumar
<chaitanya.kumar.borah@intel.com> wrote:
>
> Hello Ard,
>
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
>
> This mail is regarding a build failure we are seeing in our CI runs[1] on linux-next repository.
>
> Since the version next-20250407[2], we are seeing the following build error.
>
> `````````````````````````````````````````````````````````````````````````````````
> CALL    scripts/checksyscalls.sh
>   DESCEND objtool
>   INSTALL libsubcmd_headers
>   AS      arch/x86/boot/startup/efi-mixed.o
> arch/x86/boot/startup/efi-mixed.o: error: objtool: efi64_stub_entry(): can't find starting instruction
> make[3]: *** [scripts/Makefile.build:335: arch/x86/boot/startup/efi-mixed.o] Error 255
> make[3]: *** Deleting file 'arch/x86/boot/startup/efi-mixed.o'
> make[2]: *** [scripts/Makefile.build:461: arch/x86/boot/startup] Error 2
> make[1]: *** [/home/kbuild2/kernel/Makefile:2006: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> `````````````````````````````````````````````````````````````````````````````````
>
> After bisecting the tree, the following patch [3] seems to be the first "bad" commit
>
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
> commit 4f2d1bbc2c92a32fd612e6c3b51832d5c1c3678e
> Author: Ard Biesheuvel mailto:ardb@kernel.org
> Date:   Tue Apr 1 15:34:20 2025 +0200
>
>     x86/boot: Move the EFI mixed mode startup code back under arch/x86, into startup/
> `````````````````````````````````````````````````````````````````````````````````````````````````````````
>
> We also verified that if we revert the patch the issue is not seen.
>
> Another observation is that build passes when run on "Ubuntu 20.04", in contrast our CI systems uses "Ubuntu 24.04".
>
> Could you please check why the patch causes this regression and provide a fix if necessary?
>

This should fix it. Please reply to the patch with a tested-by if it
fixes the issue for you.

https://lore.kernel.org/linux-efi/20250408085254.836788-10-ardb+git@google.com/T/#u

