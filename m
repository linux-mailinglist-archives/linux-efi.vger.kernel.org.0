Return-Path: <linux-efi+bounces-1739-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2697818A
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 15:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3868A283D7B
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 13:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EE41DB52E;
	Fri, 13 Sep 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcUZAHGF"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318311D9326
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235595; cv=none; b=uCMMX1bljh3Gg3VJScESsTNY2+rkl3KBLFHIg6EBKGoFelhUbeMRB9uiUYPfJ+VYpaisU4anW2V9SAu6yVv4TgRT5fWkpc27/cW3zPSDr4+fOyMMtosUykvOh+4J71s9QqWW+1XYftJf0uJ1EvD7JCYS4ti4zkePRJTlg3x9PA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235595; c=relaxed/simple;
	bh=bxQY0y9CXTqolLPTyN8+UmgF4vcMBfny9q4L2tllWW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMV8h3lZiwDuESWYwrfGkqEoRKIzDwxtQED1UuSOdWbPyX7RLyCHYVmgIzzrVsH066zFtIxVM3mgKFeXUn1Vv1jenVDLNgM1e5pmGQbRIhztaviVVqwezBO+RhrzwjR9lOsqrZVgQXOUTwj3sMR62LyhNEuqKuPBXb3ZjOjAQ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcUZAHGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D07C4CEC0
	for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235594;
	bh=bxQY0y9CXTqolLPTyN8+UmgF4vcMBfny9q4L2tllWW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pcUZAHGFEkqOWwwYEkGGpBpZTQPO/UmCVZXca+gnRvzqV7n/iAchtP/gjK2VzXocX
	 Al00Bd91tLsk/CtlDHpQmoAv8RhEvT3b9XI4OHQNc4PiGsBYBohcdYmJhtL9H+dvIn
	 2FeVgNz1sY8+4esHRzz8aeWgda+mbHkK2ZdUIwvOeTQsIhqlQ1Kp8WoKbj0kBMtNfw
	 gnF0cPsIZFhQ3cFQjdTvyO7qgPktN4oAgPXTAORG56odI2VE4Uv8SXiUm2OhO+p9SC
	 D7oOw4By3G05hDxe+oY6AHnqg/l2Z02CeJTaV3d8ECMswiPbj5hN1nxgO28UBPjcPU
	 4QbumWTFdQl+Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f74e468baeso12991581fa.2
        for <linux-efi@vger.kernel.org>; Fri, 13 Sep 2024 06:53:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YwHrDElIin3EicQP9vxtdFHaHu3IBpYCsz99wsKploD62e8UGzp
	Hdr4KpnDW6BFoCkeEzuwh3uGxbv5MdUmrwxGCJVLcADgm4ANXqaglja/iGYmT6gd09fLAr3rjxL
	7w6tmEyLEi7Cy4Ka5sZqnz1tEoZ4=
X-Google-Smtp-Source: AGHT+IEwmpAh9x0igDrxUZFykdm5H6O7Q+WtscTXNLNuIYFOsWez0UaGYqQfOFjoTPUTwWfwF4GXfxOMCPMgt43OjMs=
X-Received: by 2002:a2e:a99d:0:b0:2f7:5239:5d9b with SMTP id
 38308e7fff4ca-2f7918e095fmr16871301fa.4.1726235593161; Fri, 13 Sep 2024
 06:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b6Fl9paVpZ66bxYu2jwpQPAIcEZ6UzY2iGUGKd7GSdr9dBRhvK1aLYUG-FWbVdT7YoV-x53b4kleO-krBFTrzKVDdLiCHlVsvVxGgG_cW64=@hughsie.com>
In-Reply-To: <b6Fl9paVpZ66bxYu2jwpQPAIcEZ6UzY2iGUGKd7GSdr9dBRhvK1aLYUG-FWbVdT7YoV-x53b4kleO-krBFTrzKVDdLiCHlVsvVxGgG_cW64=@hughsie.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 13 Sep 2024 15:53:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEaigChABCMrUAnkxFrEQq=Np9Zbo+CU+LdMrzu9mjYmQ@mail.gmail.com>
Message-ID: <CAMj1kXEaigChABCMrUAnkxFrEQq=Np9Zbo+CU+LdMrzu9mjYmQ@mail.gmail.com>
Subject: Re: No more /sys/bus/platform/drivers/efi-framebuffer since simpledrm?
To: Richard Hughes <richard@hughsie.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "jk@ozlabs.org" <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Thu, 5 Sept 2024 at 11:22, Richard Hughes <richard@hughsie.com> wrote:
>
> Hi all,
>
> The fwupd daemon used to read /sys/bus/platform/drivers/efi-framebuffer t=
o get the EFI framebuffer size so we can choose the UX capsule bitmap for t=
he correct size (and set the correct position) -- and make the UEFI firmwar=
e update for users a little nicer.
>
> We've found out that that API has disappeared without warning in Fedora 4=
0. Seemingly the only way to get the info now is to scrape the kernel event=
 log -- but that can't be the right way to do it? I also don't think we can=
 use the DRI interface as we don't know what card/crt the firmware used for=
 booting.
>
> We pondered if this was a regression from the conversion from efifb to si=
mpledrm. I'm using a standard Fedora 40 distro kernel, with the config of h=
ttps://people.freedesktop.org/~hughsient/temp/config-6.10.6-200.fc40.x86_64=
 if that helps. Any advice most welcome.
>

cc'ing Thomas, who was involved in this work.

