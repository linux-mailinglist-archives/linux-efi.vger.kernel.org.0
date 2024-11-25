Return-Path: <linux-efi+bounces-2208-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F279D8C3F
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7ACB23EAC
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2024 18:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489CA1B81B2;
	Mon, 25 Nov 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaqZg3qy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CA71B3948;
	Mon, 25 Nov 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559560; cv=none; b=rtVMDXa7R3t5YUDqqSy51DmgG4Dqs5IhZn9JopAANHLmqMu/1QMjf61o8KdFpYz5wgVUM9pw/KAaQNPqznF4w9NuP+HJeNNbb2z5ekB7acd8x6mygv1SdAs7cmqs3Sbjm+FGZVUXZF2tMVT7NfCKX3alsbCv6b2g+KpWc6PnypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559560; c=relaxed/simple;
	bh=xGbywVVkPjUuFusey+m/hpMXPkCVQz+XV36WyNQsUJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWwAwZKWXiEZq0Kf5Jk1gf1/94T3i2q14evz8tNSd3eB0oqpWsdXy4OmroSJeJtZJlDB1RFHMy/vh96kX9rMv3hRgW1HXp+4pX962ZQzNBMB62awuJvh3NO9Ul9vxzilEGon0CElfvM9ltnDnNXLbtF/41bEata95HxxPvRP3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaqZg3qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32E4C4CECF;
	Mon, 25 Nov 2024 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559559;
	bh=xGbywVVkPjUuFusey+m/hpMXPkCVQz+XV36WyNQsUJI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qaqZg3qyW+mtqqruvm/BbxURkwyb6r4TNtNiIiQdKnsKdzdMVi+WNLdG/WVjxAt6A
	 bG4eFj4n3aqbibIs04/5nUTlSmtwCreH11xcOE2YaLwBvzdrUP3yLtDr+6mk3kZmJt
	 Z7jSPBA8MKTdc4QdHPAbVTwCnQRfQOCZrK+5QxIthYx62tCBCYVy/hdbesXVEShQpT
	 e1XEx9AbH92I3oD1dOtgeLWu/JAk5olhTIVhMHv41E0oyhlo0H3J5FidG9i+c0UHdU
	 FHnrkF5T4MPavw24GjhW2pyD2dxLFcnUlcbQtzlGzXMo8Jx/WAAj9EGvX9Da6ytyDG
	 8aQK5qJJD7hog==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso51397e87.2;
        Mon, 25 Nov 2024 10:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViWiku8JCtflRQ94vCtk5PKy828f3A7q3gsFjtQ4JYoOuhVl2n4GLBVdClQNDK2MvYFiZHvkJKCC8=@vger.kernel.org, AJvYcCWbwvLOywzUL+CyCBz2BOMPHuRYxxJuFN0dMWdMhOmr7rZ2H/hD0h5E3cF9E1GczKMwEnDEg/wuSXW2dJdK@vger.kernel.org
X-Gm-Message-State: AOJu0YzTyZKKSJw92JMPH1S7VY/0OBOi1c722ywd4TYTY5S+TsWF6Bpv
	LfYWWflnKyIaQWIx0iwVnKXhj8Pnb+vL8fVyk2yOQn5W58EFALteWzq+n4nsfFyvsAmQ9i+8hRz
	KxaiExHMhKO3PCxssmnpjaQlJdj4=
X-Google-Smtp-Source: AGHT+IEI5lh+gdVQA6Lfo+mqAgaN7ISHNMJK2qv+IO6iBdjzAZ8YC8sotGUI4xE/3Qnhh909nMOiz6Tdlkt/WiVkV/8=
X-Received: by 2002:a05:6512:224d:b0:53a:16b:f14f with SMTP id
 2adb3069b0e04-53dd36a114dmr6317807e87.19.1732559557837; Mon, 25 Nov 2024
 10:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125170758.518943-1-yeoreum.yun@arm.com> <20241125170758.518943-3-yeoreum.yun@arm.com>
 <CAMj1kXG4A4h3=bZC6kSrwsZa7p4RZ-uN5N67pZUFLOQ2RJE64w@mail.gmail.com>
 <Z0S3wiugr0JML/cV@e129823.arm.com> <CAMj1kXFOdGaYiVWOyFEK+Lz97YdzAu+AWj5trZBTL+Xc_DXnmA@mail.gmail.com>
 <Z0S+zP3u4781zNwo@e129823.arm.com>
In-Reply-To: <Z0S+zP3u4781zNwo@e129823.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 25 Nov 2024 19:32:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHysummq5dG==gOmQr2DgtU5Ee0_tJbjGagRJniAee1vA@mail.gmail.com>
Message-ID: <CAMj1kXHysummq5dG==gOmQr2DgtU5Ee0_tJbjGagRJniAee1vA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] efi/fdt: ignore dtb when acpi option is used with force
To: Levi Yun <yeoreum.yun@arm.com>
Cc: broonie@kernel.org, sami.mujawar@arm.com, sudeep.holla@arm.com, 
	pierre.gondois@arm.com, hagarhem@amazon.com, catalin.marinas@arm.com, 
	will@kernel.org, guohanjun@huawei.com, Jonathan.Cameron@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 19:16, Levi Yun <yeoreum.yun@arm.com> wrote:
>
> Hi Ard.
>
> >
> > The DT is not stored in a variable.
> >
> > If CONFIG_EFI_ARMSTUB_DTB_LOADER is enabled, it may be provided via
> > dtb= on the command line, but I have little sympathy for a user that
> > passes both dtb= *and* acpi=force, so this is a scenario that we can
> > ignore.
> >
> > Otherwise, it is taken from a EFI config table, which is just a
> > <guid,addr> tuple describing a location in physical memory where the
> > firmware has placed a DT. If the firmware puts a corrupted DT there,
> > the firmware should be fixed instead.
> >
> > acpi=force is intended to force the use of ACPI tables on a system
> > that provides both.
> >
> > > also, although acpi= could differ from architecture, the force option's menaing
> > > seems the same over architecture (ignore DT boot with ACPI tables).
> > >
> > > So I think the check the "acpi=force" option to prevent loading DT seems
> > > good.
> > >
> >
> > The EFI stub does not care about ACPI vs DT boot, and I'd prefer to
> > keep it that way unless there is a good reason.
> >
> > Which real-world problem does this patch aim to solve?
>
> Well. I had lack of explaination. In case of Juno platform, it loads
> FDT from "Fdt" variable from the storage and install it into
> configuration table with corrupted Fdt because of FDT stored in variable
> storage was corrupted.
>
> In that siutation, If it loads corrupted fdt, it prints error message
> while sanity check in early_init_dt_scan().
> This kind of error message would be confused to user because
> user already specifies to boot with acpi table only with acpi=force
> option.
>
> anyway, what kind of way to install fdt into configuraiton table is not
> matter. but when the dt installed in configuration table isn't valid,
> it could produce the error message which seems violate user specified
> option.
>
> unless check the acpi=force to ignore DT, I think it would require to
> check the installed DT in configuration table or passed should have
> simple sanity check doen in early_init_dt_scan() so that error messsage
> which makes some confusion for this situation.
>

Thanks for explaining the issue in more detail. Juno is a development
platform with a highly unusual boot stack so I don't think we need to
accommodate its quirks in the upstream kernel.

And I still don't think this is something worth fixing in general.
Even if the machine description should be taken from ACPI tables only,
the DT /chosen node is always used as a conduit by the EFI stub, and
there are cases, e.g., for initrd info or the kaslr seed, where this
information might come from the bootloader, such as older GRUB builds.

