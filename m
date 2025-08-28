Return-Path: <linux-efi+bounces-4621-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DBB393F1
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 08:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A09C68137F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Aug 2025 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C12797A1;
	Thu, 28 Aug 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssY/JVvB"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFB1F3B96;
	Thu, 28 Aug 2025 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363273; cv=none; b=VjNM+5o0Lkvpz4HwQ4eSpPOSJZn7pNwNzTj5uEXTxFqB8Gns16Ui4XIL8DOdXbQqS8N3rvrqD0iZ7/ZXd1OknxAccpMrD79Jsa9bs7L0W2ofM+Orr2RGj7hUm0FmnwMvlUiKaAntqGCAHh4TwSsG6io5lncFB6qeZQ0wpZyb+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363273; c=relaxed/simple;
	bh=uvHu6Jg79leQgc5jk+P0upBRR7e35i0RjdRkQJjRmlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bqMWUk3Eii7W+DawpE9AAp3cJxft7aN6yKsahfavwimeFzEjtmcaajAVMp39IKLuAWn6cwn6MOzG89HnvSCQCkPy2f29hpzfs3AT1XU2f8rBpy3a4/H1mgr0gKs3b59cOopIXVTofN3JPGkL3qo7M3HEZFZwpAwbKnyhlqk8maQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssY/JVvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05431C4CEEB;
	Thu, 28 Aug 2025 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756363273;
	bh=uvHu6Jg79leQgc5jk+P0upBRR7e35i0RjdRkQJjRmlQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ssY/JVvBNfWl105pUHJ0nbujbLoxaxFh/J/Ji3i+k64d/MGbdOI2tw1U87Xm4pk1c
	 m1+0y6C1DoMc3x/Xk05rJLdK1VZqR1VTyENVOWDDP18bJZE0iWyr/8pRBM8mY0X7kA
	 7+8cGk10anS3LzHWvCSbHO2E0afCM7FsQ9lDl0ELbyQkC5zh+SS4CRY25nUP4BPxDj
	 r7Avu9NFK3U4MhkrToESNy7fsz65MDi59a08+6iCcjNi8fhXrKd2AQ09OvHzTJyQkL
	 u2PfmPh/HRJ3rdUcFa+DXAnUBbQ6m4bd6GK7vMBOOShQKE7LZGLC1PCKcHBk2ABnl7
	 wGRctEJhFDt1g==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f469ad067so686509e87.0;
        Wed, 27 Aug 2025 23:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUf7QLRHyk/7jXJKtF6y+f1ey8tBnmBvSGKZXjIKKbAc6UEIMBepw10eVULpH7hL/zX+Cw39bIWAK4=@vger.kernel.org, AJvYcCW+YWHzN42ItijhZVkMq19RIi8555iZqCBqQjjPFAqwypzmwznUHBMexShlS4rP5U/NldC5Wg8HgIezjKRI@vger.kernel.org
X-Gm-Message-State: AOJu0YyFSx3HxIDSe0Wh8NaaX9J6omyAGNqzfEvji/WZ7cg3qL8nmUiS
	wbzvUDQJhVEj6xKmqqlC3f5OMj016pENExOAy+ECcKnp7dyg+D9PiCnlF2AXkdlYHDzAqm/eLnW
	19XzVSLd0NnOiIjS4T0dxKVwqQOewruA=
X-Google-Smtp-Source: AGHT+IGIPB3Xwu5a+WuD6+HvR4o83E1B+3tbp1ucafhr7r/LxwN8bXumQLhhX6t1f/58D5YIZ8b+Lf9G0cQsN9SUqNI=
X-Received: by 2002:a05:6512:b20:b0:55f:4bc6:a5e3 with SMTP id
 2adb3069b0e04-55f4f4c6addmr2576297e87.24.1756363271372; Wed, 27 Aug 2025
 23:41:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827073954.2046464-1-linan666@huaweicloud.com>
In-Reply-To: <20250827073954.2046464-1-linan666@huaweicloud.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 28 Aug 2025 08:40:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGa7X41H5Eip+WMt3WX2HoPzoxDXHgR-4-616jhHY0NeQ@mail.gmail.com>
X-Gm-Features: Ac12FXxQN8DGxG4NlH0R8Z2i-FbHWj_fTdIO6j7nCyCbuAF9m0x4nRxJJN3VoKQ
Message-ID: <CAMj1kXGa7X41H5Eip+WMt3WX2HoPzoxDXHgR-4-616jhHY0NeQ@mail.gmail.com>
Subject: Re: [PATCH v3] efivarfs: Fix slab-out-of-bounds in efivarfs_d_compare
To: linan666@huaweicloud.com
Cc: jk@ozlabs.org, matt.fleming@intel.com, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 09:48, <linan666@huaweicloud.com> wrote:
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
> negative, leadings to oob. The issue can be triggered by parallel
> lookups using invalid filename:
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
>                               // oob
>
> Fix it by checking 'guid' before cmp.
>
> Fixes: da27a24383b2 ("efivarfs: guid part of filenames are case-insensitive")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
> ---
> v3: Check guid directly, add comment. Emphasize 'invalid filename' in
>     commit message.
>
>  fs/efivarfs/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index c4a139911356..4bb4002e3cdf 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -152,6 +152,10 @@ static int efivarfs_d_compare(const struct dentry *dentry,
>  {
>         int guid = len - EFI_VARIABLE_GUID_LEN;
>
> +       /* Parallel lookups may produce a temporary invalid filename */
> +       if (guid <= 0)
> +               return 1;
> +
>         if (name->len != len)
>                 return 1;
>

Queued up as a fix now - thanks.

