Return-Path: <linux-efi+bounces-4384-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EB6B076AF
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 15:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C36D582A4B
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615F71991CA;
	Wed, 16 Jul 2025 13:16:40 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78A1946A0;
	Wed, 16 Jul 2025 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671800; cv=none; b=aVPZs7Co/nFQ2joI1iiNLCbsP5U8LB8fVn6V/baRFovDIUQgWAoyRmhYFFgovyo9N5Fi7rRlH63iUuG8OfQosxtzOHjgGPSqwqnvfT9YSv2iDoq6b5cHfADY05jjxsGWjdtNadk/TtIwgfSK819duvqeAXLFzLQijK53wnJNJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671800; c=relaxed/simple;
	bh=/P9hIw/cBfGyTN5koBIRUN74VwVBpyBkvFKdTyLI0bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nn9HS6Tc57NoqWpJ9srHTupTnG6ObeMIlGhacFAyiQCmnBlC1RtOq9bGq/CcZUvB9Zc9+F/flJ8pa5Zz2QoQ0LYRb4/El2tGSr1HQSvXz1NpW3wWmzdK2H8yBjHftlVsAf19n/laNQIEHfUQUaCHl5/A0q/688Vy9kr3MIg2hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso12823757a12.1;
        Wed, 16 Jul 2025 06:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671796; x=1753276596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyGJS+KMC9dXK54l/iTia5pigBU87/wWhQ+q9SySWZI=;
        b=aGM8f13KFsNR7cW+Y9ebwnQJXaXelyUWGTLYAxge0zxxZHgBHDG7VoBxXVvL+kkKmK
         k4nKZCNY1US/JOvO0hPelOPq4Z2LwO4rBp6RvtmiCQuWPHHNugczXHunSW3N1Lny0UJ1
         HFKwZqtPDiIVdIYURkhr+98WV/i9flkYgbNptHNuL01lWMUwS6NrxI1LD/5PiWBL0tKO
         H56C/f/FF5uoWHM0I9Z4LEWzTxzSeXIC8tsHGaeYAskFg3AplVst0tZREvWGhqoFkzLI
         dVEkA/fkBYWuKJAbJb3p0fu2Ybg8j52LzBsJjPR8Db1hJxSuYoqx8zfJmvdYzLCrNDgK
         Vncw==
X-Forwarded-Encrypted: i=1; AJvYcCUqZO/iLsDqCE1o/QIjMbQ3LOM+DGazisVk8ftRtOcaVOqpv1jpvppM0oo4kxXA/wDVBcMv5ntMNfIK4OiO@vger.kernel.org, AJvYcCVj4II1EmFHN2zQiYaNlz55AAS+NehuTdQY2jcumqL+403GQtyR4MvianFG1wVR732XII2LZ9Ipjrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWtGi7daszWgMrlm8dj4+PgVkuYjNJ8rTbGMPmx0Fcy5b0O7rq
	j2+z2AYS4o3A4xQ0dbamdw0Rj/opZ7rMNEgGmf5Wb9PchVctU0hrAdS+
X-Gm-Gg: ASbGncttEk8ZW0HJyK9rlrlL9TwYQ6MwzsAYJtOPMqbgDN23BMaOtp7FGEbukmm71iR
	QwpUDVa0S1HKBCTHQdVmEUgtG/SLNp0iKXrSBzDp9hdVe0h4Ud2NB3Nmad3FSuUFqBCYbITr4Rv
	K7tq2/YPdxC265qq/YTHoH9paeQyqJkQQ5eBl2vC0znkcfkXa6QwwZp3Bl2bDEPwQa/kCZBvHn7
	nUABJqOj08+GY5BtBOqC3trqljZQexfo9N+8PmNcCq7LQtaOswM2orEdorV0KAjaDtLY8iWQ+fP
	zAr7ij2cC0ouIPXFD4D4xjILnKDsnUAURimViNzm4PmlW7TU1huqObiUTVEWDNHhtBezzM8p2ZQ
	n8gXhWEdfBssVZA==
X-Google-Smtp-Source: AGHT+IFbMF4D2v1gkNNVaEKXsTsAwbMER5SFzyqyYzw60SaFBPwV+KZEjDCSFDLE6XqlRBI/MBON2g==
X-Received: by 2002:a05:6402:1d55:b0:5f6:fab2:9128 with SMTP id 4fb4d7f45d1cf-612821ae18dmr3018743a12.19.1752671795324;
        Wed, 16 Jul 2025 06:16:35 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9523b5asm8823804a12.23.2025.07.16.06.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:16:34 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:16:32 -0700
From: Breno Leitao <leitao@debian.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] efivarfs: Suppress false-positive kmemleak warning for
 sfi
Message-ID: <qdw7skjlcw6dvnewpfrtxc27pm7sroan5eyn53exndehp3blav@z25oqkoo3ohw>
References: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
 <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
 <rvlw467lzx5yx3sl56u3xcc2hhhn3vj2fu7msg3e5o4giwtkcb@oomdafhhnqcv>
 <a3d063f4b0ccaad7595938ea0dca016872882f0d.camel@HansenPartnership.com>
 <7fe68ef138e43a5cf83c8b5d2dd3fc8101a8a225.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fe68ef138e43a5cf83c8b5d2dd3fc8101a8a225.camel@HansenPartnership.com>

On Wed, Jul 16, 2025 at 09:09:00AM -0400, James Bottomley wrote:
> On Wed, 2025-07-16 at 08:31 -0400, James Bottomley wrote:
> [...]
> > If the theory is correct, the leak is genuine and we need to
> > implement .free in efivarfs_context_ops to fix it.
> 
> Rather than trying to trace this, which will be hard, it might be
> easier just to try the fix below (not even compile tested) and see if
> it works.  Note there's no danger of a double free because when fc-
> >s_fs_info is copied to sb->s_fs_info, the field is nulled in fc.
> 
> Regards,
> 
> James
> 
> ---
> 
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index c900d98bf494..90a619d027fd 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -390,10 +390,16 @@ static int efivarfs_reconfigure(struct fs_context *fc)
>  	return 0;
>  }
>  
> +static void efivarfs_fs_context_free(struct fs_context *fc)
> +{
> +	kfree(fc->s_fs_info);
> +}
> +
>  static const struct fs_context_operations efivarfs_context_ops = {
>  	.get_tree	= efivarfs_get_tree,
>  	.parse_param	= efivarfs_parse_param,
>  	.reconfigure	= efivarfs_reconfigure,
> +	.free		= efivarfs_fs_context_free,
>  };
>  
>  static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,

Hello James,

I was testing something very similar based on your previous email. I can
confirm that the following patch make kmemleak happy. 

Regarding the fixes, I think this was introduced in commit
5329aa5101f73c ("efivarfs: Add uid/gid mount options")

commit 035521e8a5029ea814337d680e0552ccab1f97e2
Author: Breno Leitao <leitao@debian.org>
Date:   Wed Jul 16 06:08:57 2025 -0700

    efivarfs: Fix memory leak of efivarfs_fs_info in fs_context error paths
    
    When processing mount options, efivarfs allocates efivarfs_fs_info (sfi)
    early in fs_context initialization. However, sfi is associated with the
    superblock and typically freed when the superblock is destroyed. If the
    fs_context is released (final put) before fill_super is called—such as
    on error paths or during reconfiguration—the sfi structure would leak,
    as ownership never transfers to the superblock.
    
    Implement the .free callback in efivarfs_context_ops to ensure any
    allocated sfi is properly freed if the fs_context is torn down before
    fill_super, preventing this memory leak.
    
    Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index c900d98bf4945..07a3b9293396b 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -390,10 +390,22 @@ static int efivarfs_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
+static void efivarfs_free(struct fs_context *fc)
+{
+	struct efivarfs_fs_info *sfi;
+
+	sfi = fc->s_fs_info;
+	if (!sfi)
+		return;
+
+	kfree(sfi);
+}
+
 static const struct fs_context_operations efivarfs_context_ops = {
 	.get_tree	= efivarfs_get_tree,
 	.parse_param	= efivarfs_parse_param,
 	.reconfigure	= efivarfs_reconfigure,
+	.free		= efivarfs_free,
 };
 
 static int efivarfs_check_missing(efi_char16_t *name16, efi_guid_t vendor,




