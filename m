Return-Path: <linux-efi+bounces-2349-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0A9EB800
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E141888CB2
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2024 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0776723ED62;
	Tue, 10 Dec 2024 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F2q6Z3eE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7423ED6E
	for <linux-efi@vger.kernel.org>; Tue, 10 Dec 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850866; cv=none; b=lmXDMApxbWdJmU35PYUnvCnpszR8VHKsX5W7J2Rodh0MXFmkhJ5QBHJqZOrAPb9B/P9R5GidiNU6J+QjR6HybVmIFy4iQX8e9Ndl8J24OZsI2VMZlh+Ilj7/r6IoxDbHHGXxP8tlHB9ATWDln3whYkdMyBuq2uGNz8ZlzsAXNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850866; c=relaxed/simple;
	bh=pg6PCkAQESYCuXYSd+fcow4PqFanbzQovGB2rPsyh2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSK3Ziku4JT3uV4u1cpvL7j7XLwo31pJyJIl1nSIdMBX3IHhm34Y0xfo2zZ8jdTSROqpmwBu4ekEpmTpVAT9ZEVMYkrHvYqO9hoa7ldK8IVJ4ZNhCkFxuI/HUcQN6/y8+MvY6sP5iozyazfJwTQt0gm4f0eAiRJ65YEdqRe8kTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F2q6Z3eE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1108962466b.1
        for <linux-efi@vger.kernel.org>; Tue, 10 Dec 2024 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733850864; x=1734455664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLa40PH/Tbq3M6b/+V/XDch1i2DV24C5EIkLCdmLkko=;
        b=F2q6Z3eEmyICCp600eBBpKyuHwREEjFb+fHMg5cq07gvM6PNZ0x5/C398Q2LPztCnh
         v15U62dg8L1DWcexAeXR/QlE61x+P4qHOjgvV8Y3HOeTjNNBl/LBfyz9lXWoy6JGdN2S
         ovWEKBgZE0Kd/4JXkN/B+r7S7CSCFNJ8WMkECfDVas31pRRjMgRd/E3YMD7SqAorLcaB
         s8UB/PFmVeWK3lrWKGed1sBgJPEjLVNRmYkvWuIAJ8sOTTlzLY9t4A7P1T4zK/2q5McH
         N5zGmL9cwMffRZFM1E2ALKm6/OgA9KR0dReFBf2W3W1/X9W6DZRNZNjicC1tHypCNOUJ
         M5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850864; x=1734455664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLa40PH/Tbq3M6b/+V/XDch1i2DV24C5EIkLCdmLkko=;
        b=wkzZrYbMi7nFtLBRjKakifx2WVZ/9f+tJ65OubxklU3gqnj0aH3zeRe8JRkKKhVClP
         99phYf/JT0UUIQbaGTBM61u3pXKYHZHA/Ku8HdpV5i2pDcQDMWLk6tyg5dppLpx2QfNv
         uVAWLJqrtFEH9q0pGeQoLKcpsNPy3G4/z9xnN7dgvZUlmMGDsGz/W2i3D9YGkUZKbq4g
         J6Si38xuoBA1mG0msm7flZAwhNO4za7Rb/ujDsDoLwWvsHW2vhCB6SwgO3fa6P3t2xTR
         5gSFX25dCboPjdcyJhZZ46Qe5eDKYBKF8CqIlMbrJGp2O/7N5OE++J4fDC87Z01AS+Kk
         c8sA==
X-Forwarded-Encrypted: i=1; AJvYcCXxhnZAhwSHUaZ98nUb1v07lEI66qRxF7VK7d2lcbUaVKrMvIzZourS77SXADdJxqL4hd8J4nm4i7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGv43dGi8+Tdg7cpZc+blY4tsxATX7NXu1Z8vH0gbPEURKQwN
	GV4df2wAQ1a0dxVaM0qCp6oVjAm+dNDSl4+9KiOa0LSBjVTRXrBTWls8N43bp5LcbiNNRuJR7/i
	NY3Dnymelo5oYaKzWZjHVIB3PCpKg46wI0X8F
X-Gm-Gg: ASbGncu/1ScxX+2GHs7D7srTSF+E8PMrfPqS3n30vOmdm2StlwXrzt9KMij2g7+pBry
	O7O72cdFHN3rbaH18M8qnpehxanUJ9/9gikM=
X-Google-Smtp-Source: AGHT+IFXWYL2SzbDBfEJlksb8gpNuE+GkJfSEULi1cVyKKhpiP54QWCzdhSMm4iaNZTNIwwZy45pMnSRj/8AmdFYZOs=
X-Received: by 2002:a17:907:1dee:b0:aa6:7027:7b01 with SMTP id
 a640c23a62f3a-aa69cd5d757mr579212466b.20.1733850863442; Tue, 10 Dec 2024
 09:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com> <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20241210170224.19159-4-James.Bottomley@HansenPartnership.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 10 Dec 2024 09:14:11 -0800
X-Gm-Features: AZHOrDmJc5KDd4w3kl_yozhs3fB0y-MMK8wkfhEaJhBB4hWqpacedF8XnBUWxbw
Message-ID: <CAAH4kHaDnzY_KWkRy+fGzxOh5b9oViSfSWZ4CcQSa8n3dF2v2A@mail.gmail.com>
Subject: Re: [PATCH 3/6] efivarfs: make variable_is_present use dcache lookup
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 9:03=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

>  extern const struct file_operations efivarfs_file_operations;
>  extern const struct inode_operations efivarfs_dir_inode_operations;
> @@ -64,4 +66,6 @@ extern struct inode *efivarfs_get_inode(struct super_bl=
ock *sb,
>                         const struct inode *dir, int mode, dev_t dev,
>                         bool is_removable);
>
> +
> +

Unnecessary
>  #endif /* EFIVAR_FS_INTERNAL_H */
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index b22441f7f7c6..dc3870ae784b 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -181,6 +181,26 @@ static struct dentry *efivarfs_alloc_dentry(struct d=
entry *parent, char *name)
>         return ERR_PTR(-ENOMEM);
>  }
>
> +bool efivarfs_variable_is_present(efi_char16_t *variable_name,
> +                                 efi_guid_t *vendor, void *data)
> +{
> +       char *name =3D efivar_get_utf8name(variable_name, vendor);
> +       struct super_block *sb =3D data;
> +       struct dentry *dentry;
> +       struct qstr qstr;
> +
> +       if (!name)
> +               return true;

Why is this true? I understand the previous implementation would have
hit a null dereference trying to calculate strsize1 on null, so this
isn't worse, but if we considered its length to be 0, it would not be
found.

> +
> +       qstr.name =3D name;
> +       qstr.len =3D strlen(name);
> +       dentry =3D d_hash_and_lookup(sb->s_root, &qstr);
> +       kfree(name);
> +       if (dentry)
> +               dput(dentry);
> +       return dentry !=3D NULL;
> +}
> +
>  static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
>                              unsigned long name_size, void *data,
>                              struct list_head *list)
> diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> index 7a07b767e2cc..f6380fdbe173 100644
> --- a/fs/efivarfs/vars.c
> +++ b/fs/efivarfs/vars.c
> @@ -313,28 +313,6 @@ efivar_variable_is_removable(efi_guid_t vendor, cons=
t char *var_name,
>         return found;
>  }
>
> -static bool variable_is_present(efi_char16_t *variable_name, efi_guid_t =
*vendor,
> -                               struct list_head *head)
> -{
> -       struct efivar_entry *entry, *n;
> -       unsigned long strsize1, strsize2;
> -       bool found =3D false;
> -
> -       strsize1 =3D ucs2_strsize(variable_name, EFI_VAR_NAME_LEN);
> -       list_for_each_entry_safe(entry, n, head, list) {
> -               strsize2 =3D ucs2_strsize(entry->var.VariableName, EFI_VA=
R_NAME_LEN);
> -               if (strsize1 =3D=3D strsize2 &&
> -                       !memcmp(variable_name, &(entry->var.VariableName)=
,
> -                               strsize2) &&
> -                       !efi_guidcmp(entry->var.VendorGuid,
> -                               *vendor)) {
> -                       found =3D true;
> -                       break;
> -               }
> -       }
> -       return found;
> -}
> -
>  /*
>   * Returns the size of variable_name, in bytes, including the
>   * terminating NULL character, or variable_name_size if no NULL
> @@ -439,8 +417,8 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_=
t, unsigned long, void *,
>                          * we'll ever see a different variable name,
>                          * and may end up looping here forever.
>                          */
> -                       if (variable_is_present(variable_name, &vendor_gu=
id,
> -                                               head)) {
> +                       if (efivarfs_variable_is_present(variable_name,
> +                                                        &vendor_guid, da=
ta)) {
>                                 dup_variable_bug(variable_name, &vendor_g=
uid,
>                                                  variable_name_size);
>                                 status =3D EFI_NOT_FOUND;
> --
> 2.35.3
>
>


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

