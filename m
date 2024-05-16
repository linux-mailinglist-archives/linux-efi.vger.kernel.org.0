Return-Path: <linux-efi+bounces-1042-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753B8C7B0E
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E002820D4
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B3156238;
	Thu, 16 May 2024 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QINK+vGx"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23109156661;
	Thu, 16 May 2024 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715880164; cv=none; b=ZFPVqbBt4C1aidVAhZPXszH3ghczNQKq2YJMJYinpn+hhfPhJUue3z5+Q0+0HIzOnjieIhsBkTxmPjfy5Jy+LNeOq+Rj8y3fskzeVP+j35CKbA3v5G5tPRTpjsf46WSUr9BEh+Qt34GEBX+D6J1P8maAW3NsS7EcaIg64Boyqwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715880164; c=relaxed/simple;
	bh=JFM1sGPuHParivGYmPmZWDiZw2nFzm995pzxxSXusOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eY2wzgkTE/a6x4XAA6BLfEozhjyecTg7R1w6ktUDeVDNjjQlFqXlkeo5nvzG0gftsKKghIAzC8wItI5ym72G1e9+kP2nL1hrLq0CYlwFZ2szyYcyjaZkzUdaOoOOqXdDsDsuf2ED2CaPIn0tu20s8/hiV8L41Q+feDCoTBA7kdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QINK+vGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE93C32789;
	Thu, 16 May 2024 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715880163;
	bh=JFM1sGPuHParivGYmPmZWDiZw2nFzm995pzxxSXusOE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QINK+vGxi3IZuVEQJMqAJIuNFSJTnWHAoqiyivGMt9+T3VN/RXOA8+z2H5trl69hL
	 /RDobKlSNeLwwlFfpvFqxdBUrLwbosLGeh0+53LcN90m0Xp7SggJ+xj2iNX0EWtOh9
	 5gCdsvLxPEpv2ivj9PAGjCurHJX6RgbtEr+uo/ExFVc0VQ/abAVw6KwrzF6s9+twPx
	 vmDMwe1NGedGvbKItzyfaVj/XnzDmAfV3jWEE1jMOt3kDImSYjRkYwmYMGHBzQ7BMG
	 fmNFk8O0+PWt3e9pJmAr2TMoqovmdIiGizIYleTeo9MnEnidY0z85LsL9rdlysZoHL
	 cRY+8IIW4AQXw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e0a34b2899so14799361fa.3;
        Thu, 16 May 2024 10:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhu+tgGCxABGfD/uXFNIamJ4OYmFDkkyKn+7OOZV/KAVUwWSFeIStbnHNCBlG+xIX1GOPz2Sm2qOBVkDthwaCxt42Eoxdt3+xeuezF1z4PPAjO3473MD7/MDlVYViSH+9VTaZte6An1JTx4CDd8Dhc8lBcEaRcPVnsDQf0DFBh
X-Gm-Message-State: AOJu0YzMkaPpBDXkNzQ4E33CEH4YxpF3LfLpztDZuH0qAmPQ5pLa8U7q
	QXOu3ABfuIETo4K+mmcLRw0FHhXKRFiyE7P0G/5LKP4gWl9epubBNuIIVhf2xDWMOvNBwSIUFA0
	FxIUYQsPq3y6LpoMB7pK6s+xtFQw=
X-Google-Smtp-Source: AGHT+IFWPztwsC7lclcPXg09GrrIeEmyS9aqyetfKF0FRoF8XXGZie0XFSWi62+ssE57RGb1ryx/BRIFA/63OzvaUPc=
X-Received: by 2002:a2e:be9f:0:b0:2e3:ba0e:de12 with SMTP id
 38308e7fff4ca-2e51ff5cf48mr212358961fa.22.1715880162065; Thu, 16 May 2024
 10:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FA5F6719-8824-4B04-803E-82990E65E627@akamai.com>
 <CAMj1kXE2ZvaKout=nSfv08Hn5yvf8SRGhQeTikZcUeQOmyDgnw@mail.gmail.com>
 <742E72A5-4792-4B72-B556-22929BBB1AD9@kernel.org> <975461E5-D2BB-40FB-9345-31C4665224A2@akamai.com>
In-Reply-To: <975461E5-D2BB-40FB-9345-31C4665224A2@akamai.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 16 May 2024 19:22:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEQetR-4PtjDPaHV4EcYnJyQu1TCTN=YunCnn4MU5CH5g@mail.gmail.com>
Message-ID: <CAMj1kXEQetR-4PtjDPaHV4EcYnJyQu1TCTN=YunCnn4MU5CH5g@mail.gmail.com>
Subject: Re: Regression in 6.1.81: Missing memory in pmem device
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: Kees Cook <kees@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tottenham, Max" <mtottenh@akamai.com>, 
	"Hunt, Joshua" <johunt@akamai.com>, "Galaxy, Michael" <mgalaxy@akamai.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 16:59, Chaney, Ben <bchaney@akamai.com> wrote:
>
> The 'nokaslr' flag does work around this issue, but using it has a few downsides.
>
> First, we would like the security benefit provided be ASLR.

We wouldn't need to disable virtual KASLR only physical KASLR.

> Also, this imposes a restriction on what memmaps are possible. It would then be required to have them offset from the beginning of the memory.
>

Relying on the KASLR code to move the kernel away from the base of RAM
is rather risky - even when KASLR is in effect, the logic will fall
back to placement at the base of memory if physical randomization is
not possible for any reason.

> I also think there are a few other features that may be impacted by this, that were not addressed by the patch. crashkernel and pstore both probably need physical kaslr disabled as well.
>

Please reply to the patch if you have any comments on it. Thanks.

