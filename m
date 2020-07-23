Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F5A22A8F8
	for <lists+linux-efi@lfdr.de>; Thu, 23 Jul 2020 08:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGWG2l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Jul 2020 02:28:41 -0400
Received: from mout.web.de ([212.227.17.12]:57667 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGWG2l (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Jul 2020 02:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595485707;
        bh=1hBN9tUEwHZsp75aFn4bQ6JIGaKpS5aggvBr37cGLDw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=SgIHvSNXEVLP1YV2x7E8cn4GGBxFqIYz2e0zJHHUlktp5vNDO275pTTVlbXkD9Z0M
         WFMjFo8DFazMnV/GcNDrpw1a5c7dj4268JKIeqY4eg38QQa4FHgKQAUBQzuMfoQGtX
         mH9Qy/SW/hy6Xqi1QdkwGwSDG3GPsRUQvP9BqOtc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.132.31]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDUa-1kTRox2ua8-00doEZ; Thu, 23
 Jul 2020 08:28:27 +0200
To:     Li Heng <liheng40@huawei.com>, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Rui Xiang <rui.xiang@huawei.com>
Subject: Re: [PATCH] efi: add missed destroy_workqueue when efisubsys_init
 fails
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9255e38a-e5fb-0a41-1b6d-5fe4226e3b42@web.de>
Date:   Thu, 23 Jul 2020 08:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+cIvmW+B4FEKJmlRaUsn3P6wwZXOZBSo++wjam41Os7s/c8euNP
 SkvLdaNfwjEAG+QMwmIca39uOHG0ODw3lZpFSEdGZdH7bns/yufsNIJG5Kw4HKvPQ127PA4
 FVof1wL0RRh0Uhg3clshBzt3JnpwiqwQCTLWPW4UI8d742kS5ctOMUzQmeHvqJ+esJix2XS
 00lXuwEGHYOm7u4Z1vwOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:L/021+LXaa4=:Or5roG2IFS8LvDlPWgTW+i
 PN/jhuE+Gae9QdBPml7nb89H4lVxRZpQSI+Eg+GgTEzyMNYPBVRmJmAzq1kFQjJOiqA21yYj8
 H9ZPyiB7LyuYn284N/JsrvteAj23f4DM5BAkQZPwLGQPOm6R7yeRmjGlc1wDmEdgBh6Pe34dk
 6uxNRz72qTtC+tJg+g2FMO8DjordtRsPrA5sJOIrbwhxPR8WBGATS5wuqknUK3A04Q8C+bWlE
 rytZ0mFAyXgYe/DTXmkGHSDe/UKY2g6hXqi4M09Tb/V6IXwp3p5Nw/9v4DFiV5syPcWtAGMYd
 0Ixburob0qE/QPT4//44bWT8mqxsynBOgP8bJeiFCu9ycQJ7cl+lxH/Myvhi5RSq6waPetsL1
 9jcvYHBwUFKoeGqz1EyNTW7ON4iaIJpOWXZvDRvtbWZ8bLrfvfUdUgSbjypnM3qSFzauKFLTw
 KXuq1ZNcR3LmeDrXtOJ1MTBmcc1CoZZxbfRDuzX1YZYz9I3SVsqZQxFl7yPg2n+O6jLa5V++9
 GdAFMo8mxVyQ0qpKtuB7bVvOtkLubhuzTUHKmzTypG3Tw3kzC4ImIL3a2E8LF5WMbJUx9M4oC
 oMkAVt4DutxtSaWodz9AUSKycXcsbyzs9Jklvk6GpRdhx73uKuQJ4jccu61wMUnUIRJPmwH6a
 QhyoQdOe782jyJudId0LPzCw/3wMX+9l/oCPwczXxrlZSwseaEKSMIEJSo+a4aFBSErXB97G1
 vckUOShRqMtWsPe+f1S9+ygbA9ucfxBHKJ5LNX+bdR2EgOK8K/GaY/EYvq6NJbG+QQGZHdbCc
 IW2aGYUXL5giv4VzGPFJjTQk1r20fMBwskpq4/+k5mkfybpA/TAm2xKgL3CiJKwNlJi44uPro
 U8u6+6PoDllaAPA6y/8A81dbkSavKoCJl4FNjWcEHCJarxKh6HUczLYfV+P8ycIaEm1ZZ5Qc/
 3elANUSfI7L/67SNJyPKiV3YyZ7zgfhHA1Nc3UCmnI7Xr2DL1xnUF28c6R66Kr2bnSXiMrXQX
 ZR314qy5OpaNfgxPg1ootGZ4SjKzYof55WSpYrTjpVoqzaCVCmM4/zOYtNWIz8SEtskU7QHqR
 WRRzYOBCl+UD5TsAleatAoXyae0NTvCvXkCcKQPhKuUUhLXcsfDveAHGch4eJe8JO5Sowx9lN
 VgF4tcJG6O/uVAEK81m5Bs4XfWczvTqX4ETz5ch3RELqBh2Mt/KsdrUA8woxLSpel01C7hkgK
 IgHIv0BcqowWE3pjsZ2rcYlTjD8LmNwZnJemp1w==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

> destroy_workqueue() should be called to destroy efi_rts_wq
> when efisubsys_init() init resources fails.

* Can such exception handling depend on the data structure member =E2=80=
=9Cefi.runtime_supported_mask=E2=80=9D?

* An imperative wording would be preferred for the change description
  (besides another bit of fine-tuning), wouldn't it?

* Will the tag =E2=80=9CFixes=E2=80=9D become helpful for the commit messa=
ge?


=E2=80=A6
> +++ b/drivers/firmware/efi/efi.c
> @@ -379,6 +379,7 @@ static int __init efisubsys_init(void)
>  	efi_kobj =3D kobject_create_and_add("efi", firmware_kobj);
>  	if (!efi_kobj) {
>  		pr_err("efi: Firmware registration failed.\n");
> +		destroy_workqueue(efi_rts_wq);
>  		return -ENOMEM;
>  	}

How do you think about to use the following statements instead
in the if branch?

-		return -ENOMEM;
+		error =3D -ENOMEM;
+		goto destroy_workqueue;


Regards,
Markus
