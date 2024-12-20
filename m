Return-Path: <linux-efi+bounces-2427-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DDC9F941B
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6295A165082
	for <lists+linux-efi@lfdr.de>; Fri, 20 Dec 2024 14:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A961C549D;
	Fri, 20 Dec 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abZYn/kU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0029186607;
	Fri, 20 Dec 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704250; cv=none; b=ALRdtF/Q8i3YhCfs3xyzIOqZn8xZ53NnZZGuQNknyaTp7X8QORGad5YFcrBD2tgFzpGx0CpSgBq30ujvNPXgTteAdJehPfZplrI3do0munygjy1HuKGjWww5XEj38xAP0tehrmyc8bEqGNxLZ5rfTNFzfjw98tQtYdfwuRLugZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704250; c=relaxed/simple;
	bh=Y+Yw2PHx/7bdbVgWS5ygMMLfh0n8p3CMVOgfcQU572o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WyS3Vdp7xJRXAVHlhdX5ZX6yqkI9UHIbAH4+BBLLY6WmG9T1xNIcQ4e1er2Vwvfejan+WMAmpBxbwL8NvzPqhZdHj0SHhhz7m1nznxMo27b6PM+B3DXdrc9KYKga8uQC9HXiiDetpaEOeJrrovCYnJt7CWWpPTUU5l0QUwkbIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abZYn/kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B919C4CED3;
	Fri, 20 Dec 2024 14:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734704249;
	bh=Y+Yw2PHx/7bdbVgWS5ygMMLfh0n8p3CMVOgfcQU572o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=abZYn/kUyMI+JE2+5FDpon8mhw+eSpFEY36oG5EhAyjdHSREIadca/OjHW57obN/2
	 p7JFxwb9r+VnO+3NDEM0F9LV2UlTfLCzq1PQbrX7N9dj8A77o/A3GhB1fvIRbPFW/F
	 960VQgkOCsChj+pXLrf1YedyEi+cWl3gJTteRYiB8uN7to6B0WmTJTKz0SH6iYMfIJ
	 NW+jIYrwu9ljXvjPAZ4NaVrJgBN2Ozrl2dvnNSYMKjJwNzuGOJaVhsNikPJqiuYYbf
	 D8bJ6QyvurWB84pwLd2QgbZSySUSoe+B8rVTpEKQcseBscOLzezhZfu3X2PWT4zTCP
	 lWaVoe51xZRqw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-540254357c8so1865073e87.1;
        Fri, 20 Dec 2024 06:17:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXnZD9J+JLiWiVjuXTBbVAZJYYwsoTgU9DZhKdknAVfcEsz3NtBOuOaKfgJKuZyiOCPHz0FMe57CY=@vger.kernel.org, AJvYcCW48ELmGp5P7UQ4qKLvdW6Nbmd2rKG1iEMHG1Wc2NFdTbTjPkgzY2NCSEqAAy0wo3I9FKV6bw3pNnOsYGN7@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/e2Wi+5HV/WUa8kPA3O0xj08HlZ8VeeHlHuT/EYnvXbfrMAH
	ikDCHuQLxIaM5uzavG52gpw2q+hD/iXukTBfC7h1/5JFx3iBj6cgzxBwy43KT6pXy68gJnipaLY
	hkW24xOxHjs3CQ1IEpeHpN0++N68=
X-Google-Smtp-Source: AGHT+IEdi4iOlpwHBZdqx1GU4FG7Zsptj/xRdktRPePdj+JbmBqvw/4Nsf9wECVAaabr4p901mffXKs2wszjXZzhVt4=
X-Received: by 2002:a05:6512:350e:b0:542:2991:e984 with SMTP id
 2adb3069b0e04-5422991e989mr707823e87.9.1734704247917; Fri, 20 Dec 2024
 06:17:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220112214.2598872-9-ardb+git@google.com> <20241220112214.2598872-12-ardb+git@google.com>
 <Z2V6GKrnDHdvAEqq@wunner.de>
In-Reply-To: <Z2V6GKrnDHdvAEqq@wunner.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 20 Dec 2024 15:17:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFuMaBzTdyAcZgVQ+oX3DctD9y1DWXepw7a67HLA+azew@mail.gmail.com>
Message-ID: <CAMj1kXFuMaBzTdyAcZgVQ+oX3DctD9y1DWXepw7a67HLA+azew@mail.gmail.com>
Subject: Re: [PATCH 3/7] efi/libstub: Simplify GOP handling code
To: Lukas Wunner <lukas@wunner.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Dec 2024 at 15:07, Lukas Wunner <lukas@wunner.de> wrote:
>
> On Fri, Dec 20, 2024 at 12:22:18PM +0100, Ard Biesheuvel wrote:
> > Use the LocateHandleBuffer() API and a __free() function to simplify the
> > logic that allocates a handle buffer to iterate over all GOP protocols
> > in the EFI database.
>
> You previously rejected use of LocateHandleBuffer because you saw
> a risk of regressing older EFI versions, so that's a surprising move:
>
> https://lore.kernel.org/r/CAKv+Gu_kfnHfiBH__Wnvh39KMPj_-s39YyY=pT3roNv7iPPzrA@mail.gmail.com/
>

'previously' being more than 8 years ago ...

