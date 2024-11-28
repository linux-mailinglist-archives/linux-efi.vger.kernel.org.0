Return-Path: <linux-efi+bounces-2225-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846C09DB451
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 09:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E920FB21B68
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CACB14D44D;
	Thu, 28 Nov 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEJANNyD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B514BF92;
	Thu, 28 Nov 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783966; cv=none; b=ScOGoNWJ8g1ed1XGJ0IO91CGHiRXQJunphJ+H6JjEUbnkkX1qjkuZymXnAe3ft+Y4eoYyE8k26fqG3a8OSN15j+zvPeN9FvcA5AxiPK7F7RO6ii0EKxSZrS5EOPXlHohYznoGb6z15GLt9vueGKEckLzAMx34wHLGJ0KVtVZXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783966; c=relaxed/simple;
	bh=Q9iEQvq1bFFbAMie2f9uY+w9GcnOBWZU1XBAyAmnGTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn70GCH3R3ZYZRRygtM9OSrL/1m2yXjqLUKyYdwQ481ZNya8QaE8BIe+wYaSSPe3wWHUNrRMDuWwgol04r4ebion4x8diaRk2FXENOT6oc/eB5IEymN0DoOcyieNWAavgW03iowpqEHpzK/Epgh42sr/FrA7Nrxoj3hcCwSOE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEJANNyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6771BC4CECE;
	Thu, 28 Nov 2024 08:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732783966;
	bh=Q9iEQvq1bFFbAMie2f9uY+w9GcnOBWZU1XBAyAmnGTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SEJANNyD5w+h4OcFJUMYKawhguzj9J2EBunbxbmUc7mEtZoojuhR3IpJGGvkSO5Ir
	 b3ZzRFsVomMvrB3WjQSPcFANFnhrtwfK6kwndEtjsc345iCPpPKOyfXPd/QltHPLhS
	 eZcaACFqboEcB6JWhZClX1b9fzIMeoPm/gHvcC2Ic1gc+4kEEu4KfmvSucZUo809Lu
	 8rrMUl3cuEuelSSY++hHV37udj9xa1jGYLEOpkHgJrwgm2jWU4ekxRqsud00iq8CkN
	 vJBK+4XpMyB2LGvmEt2u0fSxARQv5OvjMx3l5C0cNWLFDtQ/id178e2QVG0PjWbqJ3
	 MOrnOSLML+4rA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffb5b131d0so5068311fa.2;
        Thu, 28 Nov 2024 00:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUp6H7nxxjVIfl5bIb9fKl8iw456owaqISmM01SRpdmZU+uy7o2x30cLvX9gVgGZpCFgDNbYOuVIl3rkPPk@vger.kernel.org, AJvYcCUwNkcM6lK7KmCCfe36HN0SB40ZLXMZxnk10ZFPYlJsBZk//Yo9PbntUT7nxtu8vCWnuzo0pGBt9GPk@vger.kernel.org, AJvYcCVU7Fn4wKlSSh8NS/XXNtkpEmVF7pCY7d+4ADN2uHGj6vh3bKjrFhHe4RfPYE2/wWqjS9u7q8cU7+X25/8+@vger.kernel.org
X-Gm-Message-State: AOJu0YwGZOKzQWKqyla9xny5uxhPE1STWGzVR3QXSdkSc1shV1qj8UvT
	p/58QewTwBakyH1E1POfxd/yp9Pe81wbUdRuBe8ODVjd9dMqd4meUBHzSZrrI9W394tqnELMiJD
	2+/WU0TyGfRsdLTF2/hoo1AsEQOY=
X-Google-Smtp-Source: AGHT+IHdlH9zt6dF0F3MIYalJvmF1iDhg89j6d+sNLtcxLQesFRAbC1hX+ToOBkqzqQ5c1xztHGfhhhG6iNXL17KAAs=
X-Received: by 2002:a2e:9151:0:b0:2ff:d821:32cd with SMTP id
 38308e7fff4ca-2ffd82133f1mr18274101fa.32.1732783964784; Thu, 28 Nov 2024
 00:52:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
In-Reply-To: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Nov 2024 09:52:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
Message-ID: <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
Subject: Re: UEFI EBS() failures on Lenovo T14s
To: Johan Hovold <johan@kernel.org>, Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Ricardo Salveti <ricardo@foundries.io>, 
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

Putting Leif on cc, although he is OoO and so it may take him a while
to respond.

On Thu, 28 Nov 2024 at 09:20, Johan Hovold <johan@kernel.org> wrote:
>
> Hi Ard,
>
> We've run into a buggy UEFI implementation on the Qualcomm Snapdragon
> based Lenovo ThinkPad T14s where ExitBootServices() often fails.
>
> One bootloader entry may fail to start almost consistently (once in a
> while it may start), while a second entry may always work even when the
> kernel, dtb and initramfs images are copies of the failing entry on the
> same ESP.
>
> This can be worked around by starting and exiting a UEFI shell from the
> bootloader or by starting the bootloader manually via the Boot Menu
> (F12) before starting the kernel.
>
> Notably starting the kernel automatically from the shell startup.nsh
> does not work, while calling the same script manually works.
>
> Based on your comments to a similar report for an older Snapdragon based
> Lenovo UEFI implementation [1], I discovered that allocating an event
> before calling ExitBootServices() can make the call succeed. There is
> often no need to actually signal the event group, but the event must
> remain allocated (i.e. CloseEvent() must not be called).
>
> (Raising TPL or disabling interrupts does not seem to help.)
>
> Also with the event signalling, ExitBootServices() sometimes fails when
> starting the kernel automatically from a shell startup.nsh, while
> systemd-boot seems to always work. This was only observed after removing
> some efi_printk() used during the experiments from the stub...
>
> Something is obviously really broken here, but do you have any
> suggestions about what could be the cause of this as further input to
> Qualcomm (and Lenovo) as they try to fix this?
>
> For completeness, the first call to ExitBootServices() often fails also
> on the x1e80100 reference design (CRD), and Qualcomm appears to have
> been the ones providing the current retry implementation:
>
>         fc07716ba803 ("efi/libstub: Introduce ExitBootServices helper")
>
> as this was needed to prevent similar boot failures with older Qualcomm
> UEFI fw.
>
> Marc is also hitting something like this on the Qualcomm X1E devkit
> (i.e. with firmware that should not have any modifications from Lenovo).
>

So the error code is EFI_INVALID_PARAMETER in all cases? In the
upstream implementation, the only thing that can make
ExitBootServices() return an error is a mismatch of the map key, and
so there is something changing the memory map.

This might be due to a handler of the
gEfiEventBeforeExitBootServicesGuid event group that fails to close
the event, and so it gets signaled every time. This is a fairly recent
addition, though, so I'm not sure it even exists in QCOM's tree.

In upstream EDK2, the map key is just a monotonic counter that gets
incremented on every memory map update, so one experiment worth
conducting is to repeat the second call to ExitBootServices() a couple
of times, increasing the map key each time. Or use GetMemoryMap() to
just grab the map key without the actual memory map, and printing it
to the console (although the timer is disabled on the first call so
anything that relies on that will be shut down at this point)

