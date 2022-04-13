Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7D4FFD7C
	for <lists+linux-efi@lfdr.de>; Wed, 13 Apr 2022 20:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiDMSKi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Apr 2022 14:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiDMSKh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 13 Apr 2022 14:10:37 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5774CD5D;
        Wed, 13 Apr 2022 11:08:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v15so3371345edb.12;
        Wed, 13 Apr 2022 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t3Z4H/kFFCbW0ZdMfLUxHxEdfJOsHw95Ck+l8KFJXOY=;
        b=kpM7EldlTHVf/3AyxgiSxvjhHU8ApOvL3dt5h/Opo0LEPmbnasw9MEjmTxMxEhYD4t
         A5gCUmPXjsIBGwYwV0lyQ3sz2rYjkN8WV/mzKSOnWT7ND8IpsGoiKHcd71+bP9/FBb2+
         LMFn7Vov8OhaLzpJadz7VmjP/rFF2zIxrRp7U8jKgvmDXvYa3RSFYWpjzO4gx56P2DVC
         H8cq3Qlx/PzG8fiWtAdWUGDIinTDITYdgyrenw3DasSxCnqWG7rG9qdTWbQhn1nb6lOj
         bqD+kL5bIF3YZzjrB6wy/w/8Xg48QmZzixwSItmrZir+WQbBS87GJ84wNZvE3EBOO72t
         KFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t3Z4H/kFFCbW0ZdMfLUxHxEdfJOsHw95Ck+l8KFJXOY=;
        b=Tnp2DgaedS8mR/+fBSxGwFKb0wNbF0XIykeZgUh/JG+xpF321lwmA2xMu2JAdkFBX5
         L6eTSppwsxt8QQW+8BWdSmh44ZTRlK8tL5fYyKIxcjmjQVhNfwV3j7VtSy0eluB4MLjb
         k4URYsuLRcD9aJXaoHQKl8mI4LerCP476gjxpS9F5gQdfhMzboejQNp9NgcdT0yoIeuA
         v0fU/HNz0GtTeBGbPzvZbDGUKCB+TrFhgglqJYO+TkBDlUuGbNW8f/v2MWMlSdClH+3N
         C1cTA3/U1GyzCIJNnVSystKEcMXHhrwN2w7ECqnjXA5KqvVQTjQRqcR/GXZwvZMmofLB
         Wc7Q==
X-Gm-Message-State: AOAM533A6K4pHtY9TRv98qQ2X0+8yznIpjlrAOZQpnjASzwyfseEnXO+
        TUlNYqgFdxy73hWjRHLsFbep9dIQgmI=
X-Google-Smtp-Source: ABdhPJyRvUjO4b6PbA+EN0H/xsxVePqfcUMyEszcuLBuOaK1OMGVkEJM0w1dcn7Gw8iWwhvNmPXBzQ==
X-Received: by 2002:aa7:d0c9:0:b0:41d:9137:fcea with SMTP id u9-20020aa7d0c9000000b0041d9137fceamr9972980edo.110.1649873293812;
        Wed, 13 Apr 2022 11:08:13 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id r29-20020a50c01d000000b00415fb0dc793sm1487440edb.47.2022.04.13.11.08.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2022 11:08:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH 1/2] efi: remove use of list iterator variable after loop
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com>
Date:   Wed, 13 Apr 2022 20:08:09 +0200
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9142505E-720F-401E-AD48-BA9D0880EDD1@gmail.com>
References: <20220331221030.889718-1-jakobkoschel@gmail.com>
 <CAMj1kXE2r4xrtFc+=OJfzutZzTtaUoFtW=f7y9+us9h+xGVEnA@mail.gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



> On 13. Apr 2022, at 19:05, Ard Biesheuvel <ardb@kernel.org> wrote:
>=20
> On Fri, 1 Apr 2022 at 00:11, Jakob Koschel <jakobkoschel@gmail.com> =
wrote:
>>=20
>> In preparation to limiting the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to iterate through the list =
[1].
>>=20
>> In the current state the list_for_each_entry() is guaranteed to
>> hit a break or goto in order to work properly. If the list iterator
>> executes completely or the list is empty the iterator variable =
contains
>> a type confused bogus value infered from the head of the list.
>>=20
>> With this patch the variable used past the list iterator is only set
>> if the list exists early and is NULL otherwise. It should therefore
>> be safe to just set *prev =3D NULL (as it was before).
>>=20
>=20
> This generic boilerplate is fine to include, but it would help if you
> could point out why repainting the current logic with your new brush
> is appropriate here.

This makes sense, I can see that the commit message should be improved =
here.

>=20
> In this particular case, I wonder whether updating *prev makes sense
> to begin with if we are returning an error, and if we fix that, the
> issue disappears as well.

Actually I'm rethinking this now. The only use of 'prev' that I can see =
is
in efi_pstore_erase_name(). It only uses it if found !=3D 0
which would mean err !=3D 0 in __efivar_entry_iter().

This would allow massively simplifying the entire function.
The valid case is updating *prev when there is an "error" as far as I =
can tell.

I've sketched up a rewritten function that should hopefully be more =
clear and
archive the same goal, I'm curious what you think:


	int __efivar_entry_iter(int (*func)(struct efivar_entry *, void =
*),
				struct list_head *head, void *data,
				struct efivar_entry **prev)
	{
		struct efivar_entry *entry, *n;
		int err =3D 0;

		/* If prev is set and *prev !=3D NULL start iterating =
from there */
		if (prev)
			entry =3D list_prepare_entry(*prev, head, list);
		/* Otherwise start at the beginning */
		else
			entry =3D list_entry(head, typeof(*entry), =
list);
		list_for_each_entry_safe_continue(entry, n, head, list) =
{
			err =3D func(entry, data);
			if (err && prev)
				*prev =3D entry;
			if (err)
				return err;
		}

		return 0;
	}

