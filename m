Return-Path: <linux-efi+bounces-4616-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3965B36563
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 15:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B108565008
	for <lists+linux-efi@lfdr.de>; Tue, 26 Aug 2025 13:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DA2D46A4;
	Tue, 26 Aug 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHZo3YFn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C35F1E502;
	Tue, 26 Aug 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215147; cv=none; b=SLQWl5JFJTRhiutwAzaW6d5OyHoIawOSzRAJGvD9RM2QH1q1Eck24rtTxSWlbzDW26nadEIcpT4DGQRDRjFKpaawfdoaHE1CpIx6wIilEZbF3aIfvQZFen7cc8uZoNCbe2jYsTtRfMHkpkgmyV/FyHdL1c6U296GDON+t6SJp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215147; c=relaxed/simple;
	bh=F9UhdwMQ0hBjRCqK9crNZJh+gxC+eYHn+B/GPo3iBo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqwFJPQjhCMbiGsyu8FPGvbpcevdmCRMUZtJieuDX1q+AT6ayTSKcO/hf9jx9TVGzHNaNZudIuwl2jjPfnW8d86M8bj9pb1PJFbhl1Ez4kSlTDUhuF5lizS6UzuAVfycgE3Gd1mfLKSS7GCzAt0h93fHfR5CSd01BJmwQWS+s8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHZo3YFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0FC4AF09;
	Tue, 26 Aug 2025 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756215147;
	bh=F9UhdwMQ0hBjRCqK9crNZJh+gxC+eYHn+B/GPo3iBo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nHZo3YFnADCYJagxhaARX7GB5flz5qYP+VDc2x7XhbArKghjbSi5LZOLxQyJeM+8L
	 He1MZW2ESHJTzltnW0EuKrXhC6S7bu0elqVazmVDGVsOcZuOpuF+Fo9cWSnXG4n+dD
	 28kRruUlWzGRnrBH0c8I3p10AMjfRLEfziNrO8p1B53clisi9uVvxXQzASaLCFKkVp
	 edgjBObImE7y2Cy8Jji7SVid8x/yUyL4qHFffPblE1VIzWCQHn3mIkCao9cpzBaVkV
	 uQLVvbBiUSuQM6Xqlt1UjVW+JU1Flg3AuJlQjbWP+s+NMt1iSrQ6BakANSJFq6Yym6
	 r2GZa/EBvtg4w==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3367f35d11aso14107711fa.0;
        Tue, 26 Aug 2025 06:32:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/1GkIq/WQTIty3f3Cbv9uqN+oblumDLEih4cnlz9HZDGg7/EXX3zj4s1mRuum8iskesino41dHgg=@vger.kernel.org, AJvYcCXSFqYeKyEfmROsH/evP0zEU0Svd0JPD+h0FtcqGqitIXPawvSyqpYyxy2RvkZ4ZGz8wr2mUd0RI4W0wnnF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg277dNlWQqkiCL2Kl4ySGsWWbrWNASshauVIEadNzAv8tkO+c
	xGfT4efsVEoypMF9W54vk3bRLXaYprCMhCROiibr6J8VwtC3V8i6py1z+xRa3UUyN9hI45mNJG7
	Q8kOl9+3KXS+oQ5ecGkxDZ8hEHERPHiI=
X-Google-Smtp-Source: AGHT+IH0JU0rh2F2/IGrODV0cITg40GykiWYazxaj+7uUdbok+BkQQ0z2AXH9CyxNwKoJ0DFz3gtVpCAyySkIf/fd7A=
X-Received: by 2002:a05:6512:4488:b0:55f:486b:7e44 with SMTP id
 2adb3069b0e04-55f487ac7b1mr1496884e87.37.1756215145733; Tue, 26 Aug 2025
 06:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819090802.2258766-1-linan666@huaweicloud.com>
In-Reply-To: <20250819090802.2258766-1-linan666@huaweicloud.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 26 Aug 2025 15:32:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvEOTHHshS9uoL4RSZgJZgd9OR9qzPHYJ5xW2Vgeefcg@mail.gmail.com>
X-Gm-Features: Ac12FXzNlYX0397R9A-yMbFf875GVSnv6G1xxJnODLQnCjpaKIVrANlolXzJWvc
Message-ID: <CAMj1kXHvEOTHHshS9uoL4RSZgJZgd9OR9qzPHYJ5xW2Vgeefcg@mail.gmail.com>
Subject: Re: [PATCH v2] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
To: linan666@huaweicloud.com
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Aug 2025 at 11:16, <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Observed on kernel 6.6 (present on master as well):
>
>   BUG: KASAN: slab-out-of-bounds in memcmp+0x98/0xd0
>   Call trace:
>    kasan_check_range+0xe8/0x190
>    __asan_loadN+0x1c/0x28
>    memcmp+0x98/0xd0
>    efivarfs_d_compare+0x68/0xd8
>    __d_lookup_rcu_op_compare+0x178/0x218
>    __d_lookup_rcu+0x1f8/0x228
>    d_alloc_parallel+0x150/0x648
>    lookup_open.isra.0+0x5f0/0x8d0
>    open_last_lookups+0x264/0x828
>    path_openat+0x130/0x3f8
>    do_filp_open+0x114/0x248
>    do_sys_openat2+0x340/0x3c0
>    __arm64_sys_openat+0x120/0x1a0
>
> If dentry->d_name.len < EFI_VARIABLE_GUID_LEN , 'guid' can become
> negative, leadings to oob. The issue can be triggered as below:
>
>   T1                    T2
>   lookup_open
>    ->lookup
>     simple_lookup
>      d_add
>      // invalid dentry is added to hash list
>
>                         lookup_open
>                          d_alloc_parallel
>                           __d_lookup_rcu
>                            __d_lookup_rcu_op_compare
>                             hlist_bl_for_each_entry_rcu
>                             // invalid dentry can be retrieved
>                              ->d_compare
>                               efivarfs_d_compare
>
> Fix it by checking len before cmp.
>
> Fixes: da27a24383b2 ("efivarfs: guid part of filenames are case-insensitive")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
> v2: optimize commit message
>

Thanks for the fix, and for the elaborate description.

IIUC, two parallel lookups using an invalid filename can reproduce this?

>  fs/efivarfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index 23ff4e873651..c30d758e303a 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -152,7 +152,7 @@ static int efivarfs_d_compare(const struct dentry *dentry,
>  {
>         int guid = len - EFI_VARIABLE_GUID_LEN;
>

Could we do a separate

if (guid <= 0)
  return 1;

here, with a comment describing how that condition might become true?

> -       if (name->len != len)
> +       if (name->len != len || len <= EFI_VARIABLE_GUID_LEN)

... and drop this change.

>                 return 1;
>
>         /* Case-sensitive compare for the variable name */
> --
> 2.39.2
>
>

