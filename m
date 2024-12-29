Return-Path: <linux-efi+bounces-2488-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D449FDE69
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D0F18825F0
	for <lists+linux-efi@lfdr.de>; Sun, 29 Dec 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985CE78F3E;
	Sun, 29 Dec 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkDif80E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25F3214;
	Sun, 29 Dec 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735466948; cv=none; b=phyNhTDkjf2lH+nAO11LwJKU3GfiUNY2xlbMkbPfNzavKxsfu8mbDPs4b6YO5nTHXkwzMPzXG5P9OGd90ii0vIzCoMcQN8Pj9Y3veB5NWRRINyj/WaZZ496WJDoyMTjuXx8jJOGgepqppXMcFDYUWpeIvmCoLatsI8LhBwqPf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735466948; c=relaxed/simple;
	bh=imOemKLhXJbPAHJOBwKpdyRz4WP8H+vxyrxDWEkbna0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lav8FlqbpIVmjGQKJ2C4sbJ2blAZf7zlm6fLTgNmZaYDrS//9QBMAvlaez8e0UATvVvyX8B3aWO6FrKg89x/uq8+wduWEfVf8fOeTld1nrs8rBoMhfXwL2H8fGt3AFF48ERcKFk9f9mpVHV/XtlsNg9WEZKGqs47wTgiE9hMW8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkDif80E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0545C4CED1;
	Sun, 29 Dec 2024 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735466947;
	bh=imOemKLhXJbPAHJOBwKpdyRz4WP8H+vxyrxDWEkbna0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XkDif80EsJJ2b0VR7btoe8bJ08bRdISTUSdoTelDF1mEYAe3tun252Yppu8XnsqIH
	 F1W/XlBrO/VLqYy52q6bdp+MAxLwFbrm0mxTqQs1zHIJRdkOlH1l4PxgJK0FK/XqCs
	 zx1VuIxJUi9AAYY5fwIQtRHGjaGBx4sGYuTsXLyaEyz24LHVuKmWXFQTIPpU1qj4xD
	 bFEx+C1MFoMAoB5FddRxFyMlYItigyzwRse32G4X+yLsQhvqVzw6S5/gSdPw9V7j6T
	 oUoK/okVS3IMcsPLnPuYPg7gPsFsgKn5g6zvkxKNCx2KZQqVsGdY61nA34kk+gPsrW
	 X+qfEPDiCzrkg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54024aa9febso9434730e87.1;
        Sun, 29 Dec 2024 02:09:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9wB0+PBInswvecEHvoj7MwKtAD/Hrn8edc72P2u70sgILw4y1wOf0jv1uc4f3J87PDzeXVAFMd1Q=@vger.kernel.org, AJvYcCXkoi3v3u7EUveS+6RdbduYGVrdlWWZcH9EgP08dGFDzjB9KFYgxe46dUZNuadDb7Stezwh/By51jW8L2if@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Yjtkim/N1Nxh2qFobd6V7O0Gb1DqPjgvQxKuj3pBCuzTRDci
	fP/GjwREory9trpM3kjLPlglOFmMBgCL/OGVTk5Mupx8Cf288tCARzrjfNWBNtx6U4176o1A32O
	VgvLnBLyEh+Z4KDT1p4umnNGFgJA=
X-Google-Smtp-Source: AGHT+IHrzOVsbxMTIGQkvFHeqgMYn85PFGZGuMiBsv7r7D+zJEgaO+d7KT3pGTAlTZO5iGTu3nnEystLHaYLIXRmurA=
X-Received: by 2002:a05:6512:2246:b0:540:29ac:bda5 with SMTP id
 2adb3069b0e04-542295253e3mr10279463e87.4.1735466946291; Sun, 29 Dec 2024
 02:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241228202212.89069-1-lleyton@fyralabs.com> <Z3EdkuCBzTGzTHK3@wunner.de>
In-Reply-To: <Z3EdkuCBzTGzTHK3@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 29 Dec 2024 11:08:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
Message-ID: <CAMj1kXHWoD78QdFnEY_=Mtz02zN3rhN5+Skgv=fHG91TD8Mmvw@mail.gmail.com>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os protocol
To: Lukas Wunner <lukas@wunner.de>
Cc: Lleyton Gray <lleyton@fyralabs.com>, gargaditya08@live.com, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Dec 2024 at 11:00, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, Dec 28, 2024 at 12:21:58PM -0800, Lleyton Gray wrote:
> > commit 71e49eccdca6 ("x86/efistub: Call Apple set_os protocol on dual GPU
> > Intel Macs") calls the Apple set_os protocol, but only on T2 Macbook Pro
> > models. This causes issues on other T2 models when an egpu is used.
>
> How so?  The commit specifically constrains the quirk only to
> affected dual GPU MacBook Pros.  So I don't quite see how this
> would affect other T2 models?
>
> And what kind of issues are you seeing?  Could you provide
> specifics please?
>
> > Add two options which allow force enabling or disabling usage of the
> > protocol to fix.
>
> We generally try to avoid command line options.  The kernel
> should automatically determine whether to apply the quirk
> or not.  So I think the proper solution is to amend the
> quirk such that it's applied to additional models or not
> applied under certain circumstances.
>

Indeed.

But first I'd like to understand whether this is really the same
issue, or another issue that requires the quirk.

IIRC, the original issue is about not being able to use the discrete
GPU with the built-in panel, and the issue about an external GPU did
come up in the discussion - however, this does not affect the built-in
panel at all.

