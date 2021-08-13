Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661983EB5F1
	for <lists+linux-efi@lfdr.de>; Fri, 13 Aug 2021 15:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbhHMNGL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 13 Aug 2021 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbhHMNGK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 13 Aug 2021 09:06:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FBC061756
        for <linux-efi@vger.kernel.org>; Fri, 13 Aug 2021 06:05:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h24-20020a1ccc180000b029022e0571d1a0so6866597wmb.5
        for <linux-efi@vger.kernel.org>; Fri, 13 Aug 2021 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Az25A5x/PdwdJuehTHoxGPnJuAOFukArWqBYhfKoCuo=;
        b=X7s8vsznwuq3sgmvKGpUFnXRXoWN2s9brvS4U9r3xbLD36jpVd5+zKXV7PzpkbkYEq
         VmW3S1vKoOeQdwj1Y+UNbUhLU2cQr1v3DwfLtn4IS2E8BzjSjYrgr7/UpSbg7mDMmOKD
         cSPGcDkNYyuRmLe+qVoQJRLQ5cjEdf7ar0MBJU0jC1fTKHffBLV/+OZiDNEfi4DupV/C
         U0TeBHwRRcGIPNu7ZwasxZ60AZWqB7tUq6Gm6EGgHLS0P7RjJOHekpFABTLvI8+/L6wK
         A3/NDW8b+oqSF+oK8QmHulDQKB3n94v3AnxBB6KsmExMKrp7YA1Rx2U95aN2m9FJzFDx
         CNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az25A5x/PdwdJuehTHoxGPnJuAOFukArWqBYhfKoCuo=;
        b=V5PzbWmb0CZzlgGt3Ak8m0hH7rdcPyaYX2tqnRsW847f9Yo3OpF2PQtr0CQJ+3kzD/
         FqyrdksUc2qjIDdOQs8PUm85cs0pBHKYumSVpNSWjpPtX2dApQaurZShmZq9mm0i8nme
         sH5b0bGrOIwqnGDRoARoSR99iTYY8DwoBZ3B5slsu9oRr8lKBOedxBgn4CYn1uCYr5io
         5y7YTjFOHkssIvvJeGhaL0SpOohW/DWjd643CCfxS7VVtpmixIFbmYke3LP4nJhMpoR6
         A6NZwnT25h1wkntt6ar9Djk6mUibpL9FuGGdR/wmWPwwTuw1VT8iMDEM1VD8ik2GK9ZC
         t2ow==
X-Gm-Message-State: AOAM533/fvVwADsatuWmZlB5hdMkJlPKTQ13+8Pv41hYPhfwV6lgkSOz
        Am3QKd+W0tn7WohmmLqZhBi+dQ3Gf0aUcg==
X-Google-Smtp-Source: ABdhPJxqTD4RVXl09jnftd9ObEZ7XuwVakw71LGUpGiVyk7qUuDfTl6DEMDWZAt2+9HcAH8/TvV2Bw==
X-Received: by 2002:a1c:1dc4:: with SMTP id d187mr2653893wmd.1.1628859942307;
        Fri, 13 Aug 2021 06:05:42 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id u6sm1481782wrp.83.2021.08.13.06.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 06:05:41 -0700 (PDT)
Date:   Fri, 13 Aug 2021 13:05:36 +0000
From:   Andrew Scull <ascull@google.com>
To:     Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] virt: Add sev_secret module to expose confidential
 computing secrets
Message-ID: <YRZuIIVIzMfgjtEl@google.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
 <20210809190157.279332-4-dovmurik@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809190157.279332-4-dovmurik@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 09, 2021 at 07:01:57PM +0000, Dov Murik wrote:
> The new sev_secret module exposes the confidential computing (coco)
> secret area via securityfs interface.
> 
> When the module is loaded (and securityfs is mounted, typically under
> /sys/kernel/security), a "coco/sev_secret" directory is created in
> securityfs.  In it, a file is created for each secret entry.  The name
> of each such file is the GUID of the secret entry, and its content is
> the secret data.
> 
> This allows applications running in a confidential computing setting to
> read secrets provided by the guest owner via a secure secret injection
> mechanism (such as AMD SEV's LAUNCH_SECRET command).
> 
> Removing (unlinking) files in the "coco/sev_secret" directory will zero
> out the secret in memory, and remove the filesystem entry.  If the
> module is removed and loaded again, that secret will not appear in the
> filesystem.

We've also been looking into a similar secret mechanism recently in the
context of Android and protected KVM [1]. Our secrets would come from a
different source, likely described as a reserved-memory node in the DT,
but would need to be exposed to userspace in the same way as the SEV
secrets. Originally I tried using a character device, but this approach
with securityfs feels neater to me.

We're also looking to pass secrets from the bootloader to Linux, outside
of any virtualization or confidential compute context (at least a far as
I have understood the meaning of the term). Again, this feels like it
would be exposed to userspace in the same way.

It would be good to be able to share the parts that would be common. I
expect that would mean the operations for a secret file and for a
directory of secrets at a minimum. But it might also influence the paths
in securityfs; I see, looking back, that the "coco" directory was added
since the RFC but would a generalized "secret" subsystem make sense? Or
would it be preferable for each case to define their own path?

[1] -- https://lwn.net/Articles/836693/

> +static int sev_secret_unlink(struct inode *dir, struct dentry *dentry)
> +{
> +	struct sev_secret *s = sev_secret_get();
> +	struct inode *inode = d_inode(dentry);
> +	struct secret_entry *e = (struct secret_entry *)inode->i_private;
> +	int i;
> +
> +	if (e) {
> +		/* Zero out the secret data */
> +		memzero_explicit(e->data, secret_entry_data_len(e));

Would there be a benefit in flushing these zeros?

> +		e->guid = NULL_GUID;
> +	}
> +
> +	inode->i_private = NULL;
> +
> +	for (i = 0; i < SEV_SECRET_NUM_FILES; i++)
> +		if (s->fs_files[i] == dentry)
> +			s->fs_files[i] = NULL;
> +
> +	/*
> +	 * securityfs_remove tries to lock the directory's inode, but we reach
> +	 * the unlink callback when it's already locked
> +	 */
> +	inode_unlock(dir);
> +	securityfs_remove(dentry);
> +	inode_lock(dir);
> +
> +	return 0;
> +}
