Return-Path: <linux-efi+bounces-5226-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEADC1B808
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 16:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BF4188FA6C
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887971DE4FB;
	Wed, 29 Oct 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fQrNdVj+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B813358B6
	for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749388; cv=none; b=fCuiPQp1kpFj2mdnpJu7BtxXWC/yWZpiI7vx701Cg/h1bGPOwPVZZK9aLBeAC7/pOTIssQR3G9YqHZyJgH79FaWcxH7pwJkCJBRJ/ozfz7GFdYULmjse5kBVwlJ2G0BUgrnGwPpa49qO4GVF96xUg8Knfl3yEgaP0lzf73jHHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749388; c=relaxed/simple;
	bh=N/H9Hc3aJwCtzPmRJOck3fIp82+NkA0LZ9tUFRkG0Bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9VsZ7V2jUmeG4/Wn9O4Mdy7/YcwYhgyZH0gvpyV58SI+7UARN+33xu1kFBwUXZQGicB13etn8BQiBs8pYQMTe7O9qyDBgHrYvbiLFa9qTfcwT3sq/4H/nzXz20Iuf5AyWkyqFOFU9q3ZNAF+vTQSxQMN+HFDgU1M7ag1QbbW+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fQrNdVj+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34029cd0cbdso2755594a91.3
        for <linux-efi@vger.kernel.org>; Wed, 29 Oct 2025 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761749386; x=1762354186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=fQrNdVj+n9mN+TjKgSWKOurWOx8bbFjjcpGc9rbYoX0l9pVxeVS7dwbebPzO7EyMNY
         X2a6Ew+yUq3XXoV/wDq9lkypSK+BYom/rU7WeWRWYvwk9ud2ZvZAMsTQBqg7to0voVyE
         NWPDqGEFI4ycZ4bfSeWBglO8aPeHliM7090p3jHq/UYBn2TX8A3J0QsThKh1Ht7dMrwU
         sdWywmc9wuO5fUMz26trsoLjWgo5P7gJSrB6Xfqf+DBYqgz8bPGcaEGWivFwD1drHXXf
         CRZ7/nRNpUUvgNm2zoncIx+LpnHqQOmwhHcuMIuiiS88r9eKzaxFewWxm80ztiA9EXIT
         k9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749386; x=1762354186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsfcHn1joSx3FYcBHFCIU4wVQAcpbVHvkEyCsZn4M7g=;
        b=bKdYBkqKAWpp3J3pfOsKbmTxpK0q6CwnnBqZmMh7hozJABlTn2ZkpZvSYCSjrxW7Nc
         M3xTxvAWZDMJ7XmJ1Q14BmXZ9wSx2y1I7G11Ylt+3NMVY1da380R8MafvBkvUuE7gBdQ
         Oq4A380B+o+qWKoJbh3OU4W1kQlOAaN6Rsx11LRtck/HCXErgIx+Oag5xlr+/5Twi3Wi
         k9IkYKWiqxrUwNX2k9L7hPB7G0mIO30BetP/Y3OS/HwW4v+W+Ah9/XWWdZYS9Y7eu1BX
         /2EDLzRzdtLaedKMi3ozegPJtXmyK60k4aDIwbpswtJ7rJfz+Neu43/RrYOb+i3wDv1Q
         PGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7i4YJuPLW+ADIxo3JUirRcs/shM5WRKL6Aw6AFYpGFCIlTccVkJKIg5ZuFF2aQv2nLpYTu9jOgxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYedkb3GNoC3kHSHvX8G20O3xErK3wmbMXy5XvDqhPNwVxhz53
	5CTuigwoS51UTVXKyM04fxv9KykG4Yvkf7ljLBr5/MuH5sOa1jcY1YqXW0Z9bB6MMVvemp+HNRY
	/KwESqhZEfj3S//aVCnUuUSZgMYU5R6qcy0B5rLqu
X-Gm-Gg: ASbGncuyQ0G8CoM/HOB7L3PFAO38oB2vUw6WVIcA8npSeV0bogu1XboInTy5GPGH8Lt
	oQhHUPSGO5K6PaodFA8CzGpcLtvnG7FWQt+hvcJwMiPLGg+26NuX6rOGrlgDr/fb7NMGe+9WXQX
	1Q3QX0TV6XBn7FO4oW6QJ3c4GyKIZK4HqGCr7qAHH065nQwnZvFRF3VorS2biDNhjoZ64bjHeUI
	56We3mxp8X/f9m7udNKEZbK8HYxg8Bk4af9MYRiLiucXHd9RpE2WByu2qfO
X-Google-Smtp-Source: AGHT+IHiN2wVay8qKwNUCQNQedszNEqWD+gbH8QhJy+T+EtTl6Gz4GwA6YgaiehmmoZJBoAentF29nQI5J4sc3vsbuw=
X-Received: by 2002:a17:90a:d64d:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3403a302f52mr3761415a91.36.1761749386246; Wed, 29 Oct 2025
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-36-viro@zeniv.linux.org.uk> <CAHC9VhRQNmPZ3Sz496WPgQp-OkijiF7GgmHuR+=Kn3qBE6nj6Q@mail.gmail.com>
 <20251029032404.GQ2441659@ZenIV>
In-Reply-To: <20251029032404.GQ2441659@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Oct 2025 10:49:34 -0400
X-Gm-Features: AWmQ_bkw5gzRbiAC20oxF8nOixccAI_lXABYmuYCSfnezye7FZYc2Gs15NqnG0I
Message-ID: <CAHC9VhRefx4MBDU78Qob7Pe2pDLK=1HK4b2EuTtENVssntHecQ@mail.gmail.com>
Subject: Re: [PATCH v2 35/50] convert selinuxfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, miklos@szeredi.hu, 
	neil@brown.name, a.hindborg@kernel.org, linux-mm@kvack.org, 
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, kees@kernel.org, 
	rostedt@goodmis.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 11:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> On Tue, Oct 28, 2025 at 08:02:39PM -0400, Paul Moore wrote:
>
> > I suppose the kill_litter_super()->kill_anon_super() should probably
> > be pulled out into another patch as it's not really related to the
> > d_make_persistent() change,
>
> It very much is related - anything persistent left at ->kill_sb() time
> will be taken out by generic_shutdown_super().  If all pinned objects
> in there are marked persistent, kill_litter_super() becomes equivalent
> to kill_anon_super() for that fs.

Gotcha, thanks.

--=20
paul-moore.com

