Return-Path: <linux-efi+bounces-4479-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F27B1169E
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 04:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1245E4E771D
	for <lists+linux-efi@lfdr.de>; Fri, 25 Jul 2025 02:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0E2356D2;
	Fri, 25 Jul 2025 02:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NnZNDbMp"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9587F9D6
	for <linux-efi@vger.kernel.org>; Fri, 25 Jul 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753411438; cv=none; b=fHahXrjL15XrbgiLH3vLCTswUBJquVxldwJsj3qT1RElDiwIuBZYBqTPXUgU7AGpWUkX8NhliiE1X9kLqs7c3syyQceMyvDRYygK1cpUXnHx0nFw2Wf4C2w0kQEWtFO58C55dtBi9QhWJkFlLm5YjB9gnxbAIshEybVsWRBr73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753411438; c=relaxed/simple;
	bh=7hlZomtnwSEYXgOyb5FEyanHu7jwB5H+48d2zwgeTUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF7GKiHnLcWH6Wu9GATtNkMZ8C3DWwDabAa1RYOsQepJ401MNogb5itDiagEbzGXm5ykSRtUq/4+ax0FDWdGVGNaE/myXvFO8LHonSpxZMv07WYbmjHjPLGBqTBZT11RSawdFhnlZ4+9NqMIyEyzKHeiPZcLK8hyDcZ8eLMkhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NnZNDbMp; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso1515730276.2
        for <linux-efi@vger.kernel.org>; Thu, 24 Jul 2025 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753411436; x=1754016236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FySz+cRu8BfNFHOSnCCE2y4s68tkhJQYIqvY80ZJOyg=;
        b=NnZNDbMp6cO1yeqOxSzJnQHbtkt8YjbLFdeK2oiZJOaqEDKfGwtANFCOytqsmHBnpX
         g07As2ZGtKdnx632yB3Fo9nZEHYkmlOZHr9gFo4Gv0zp4ApBc/Qw54MEV+efM0iYV+KP
         IEIcpQ4n72+XHkp9T3xNcDnZPqnTvL1EMN65rZ87N8iTXGgt44UuNPtTt3pTIptjd37W
         pddb1v+TIbQR7xW5DgCVpRkCSqmnWMmn7KUz/I+wews+3ls06v544i3VBezGGny3IT6u
         P3hkZfT7U9DezUjN59PpiI/S/tyuzjwSkZgO9ok+oht6MEh3NAkQvLz9Q0YaWb/0xwvK
         XhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753411436; x=1754016236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FySz+cRu8BfNFHOSnCCE2y4s68tkhJQYIqvY80ZJOyg=;
        b=uXUKAh0IBTdgXTAgHH9HZJBp9Q0EWPGajq58olfeGwSydaQAYBV7NjaX4Gs0zmk21u
         IYBkXKLoHTHBd17xMu/QSCty2hjMwpqlM2wDf3CqE5eKPp0xYAXjNp8BSqSrZp9NzeQR
         DwNQANF8eFsHbt54jos12Kr4RAodFGSO79/C1ILivMYCqv6OemPkIK8x5KVUhh5cdbzW
         D5BvZB9vtN9xDOhJjjx3MEXZCa+dZTPpK7ugSClezF2Jhzbk99W7HCMiazg+4U2R5g11
         NZfzJxyiOepqdK3Py2ddCeM9YsYlUP5DAYgVRXc7XjMH/mtzHy2Z2B2USoZVhxdvfvnE
         tHIw==
X-Forwarded-Encrypted: i=1; AJvYcCV+RwWK5L5WuFgmyGoOeF3RGpx5rq9XQAjqYFITL6cPxFsYh0HmzTaiKkdUbc5nyOKcyNScuUIvVIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2I3ZvspfafbDon3AGtbltTcW3p0v3WCU5MO+SaWXyViEETSe
	r+i7AoPz+hXK2ESfS1nGLy8sjAIRe4R+B1YoItxWhv3HJARxFytgAnYOu/RqKgCakm634iuRLbk
	cFnx9aiWazM99QAXgz4f2mGtddVbVnM7fl/EiKDJ0IQR6x7pcM4w=
X-Gm-Gg: ASbGncuHLdJ0kgCZr/iL7zaX3bn5Xfn3k4nQb2fpzaO4o3AG2eY3z2ee7W0NwPYS+GT
	eJqt5W9nVHHIIiYEPu4wc1JE2runMiYsTcXufosn27vn1Y27IyRa6eySR1XXh9QA4hPEpH3Jcsm
	Njhe/Q3tLyPh13Fy2B4pWpohDpV2BFubzkRXStqh6LdbrMC7Tz8hFXcybyEUFe++juhNocT1SkO
	/2Lg+M=
X-Google-Smtp-Source: AGHT+IGy0kReF31F1j3wAaPhrwrQg7J25T0JtgcUwvIMbS5nqsDq9A60L8ppu0vixFFhHxaUG+UyC2kOcMggzd4esWk=
X-Received: by 2002:a05:6902:1747:b0:e8d:9f9a:79bd with SMTP id
 3f1490d57ef6-e8df1134dbemr143078276.17.1753411435973; Thu, 24 Jul 2025
 19:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1750975839-32463-1-git-send-email-hamzamahfooz@linux.microsoft.com>
 <20250716212925.GA14322@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHC9VhS3qY=+DVYqzkgbHLETUo4KgQ17qr_BC3pn9TeG+cr8Mg@mail.gmail.com> <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
In-Reply-To: <xfabe3wvdsfkch3yhxmswhootf5vj6suyow5s3ffumcnjkojjz@e7ojgu3s7ion>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Jul 2025 22:43:44 -0400
X-Gm-Features: Ac12FXx7R_BHZgXqsCbTxD-hHKdNeH-KBiya6C276YAbabcH3l3gvX9QAvZbV9M
Message-ID: <CAHC9VhQ+4=J=nf2Yeb_QACVD4-d3_aUScpBAZhGyj7_+z+mBEw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Secure Boot lock down
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Yue Haibing <yuehaibing@huawei.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	Kees Cook <kees@kernel.org>, linux-efi@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 8:59=E2=80=AFAM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
>
> Hi Hamza, thanks for your patch.
>
> Thanks, Paul, for the forward.
>
> Sorry for the delay, we took a bit of time to do some lore archaeology
> and discuss it with Xiu.
>
> As you might know, this has already been through debates in 2017 [1]. At
> that time, the decision was not to merge this behavior.
>
> Distros have indeed carried downstream patches reflecting this behavior
> for a long time and have been affected by vulnerabilities like
> CVE-2025-1272 [2], which is caused by the magic sprinkled in
> setup_arch().
>
> While your implementation looks cleaner to me. One of the points in
> previous debates was to have a Lockdown side Kconfig knob to enable or
> not this behavior. It would gate the registration of the Lockdown LSM to
> the security_lock_kernel_down() hook.
>
> However, what bothers me is that with this patch, if UEFI Secure Boot is
> activated and a user wants to disable Lockdown, they need to go through
> disabling Secure Boot. I'm really not fond of that. A user shouldn't
> have to be forced to disable security firmware settings because of a
> kernel feature.
>
> We thus might want to add a way to disable Lockdown through kernel
> cmdline.

One can enable/disable "normal" LSMs via the "lsm=3D" kernel command
line option, however, as Lockdown is an "early" LSM, it is enabled
prior to the command line option parsing in the kernel so that isn't
really an option unless we add some mechanism to later disable
Lockdown during the "normal" LSM initialization phase when the command
line options are available.  This would result in a window of time
during very early boot where Lockdown would be enabled, before being
disabled, but I have no idea how problematic that might be for users.

--=20
paul-moore.com

