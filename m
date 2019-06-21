Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7D4E740
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2019 13:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFULii (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Jun 2019 07:38:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49440 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULii (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Jun 2019 07:38:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190621113836euoutp0109705914a7a2a380bbeab8c4e8ffcb3a~qM771W0L61618516185euoutp01I
        for <linux-efi@vger.kernel.org>; Fri, 21 Jun 2019 11:38:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190621113836euoutp0109705914a7a2a380bbeab8c4e8ffcb3a~qM771W0L61618516185euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561117116;
        bh=k4QCFgb0wAh369BYDvWvGGd1TbzGRKg0PrC3exSaCK4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vI7n6hxP7UNeyiAW9WnOGPg87wPBUJyQzcJRt440kq+fISFgOZZVVOQurSBe+9xly
         8Haub+wbFNg3VqIrzHTuNBnzyVpm0CudU/4VxITH59Mwx0jLxyOj48Gz3SB8VjritD
         VddpsUjsoPDsfymPVpvgQUJQ07zQApdL2YVqrfqI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190621113835eucas1p2db04a6e3d276c69de6b748d6bce7b974~qM77fRZJQ0466604666eucas1p2j;
        Fri, 21 Jun 2019 11:38:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id EA.2F.04377.BB1CC0D5; Fri, 21
        Jun 2019 12:38:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190621113834eucas1p1ef78d2bdf1a2a47ebfaa35f6f01f0bd6~qM76qTP2f1120011200eucas1p1K;
        Fri, 21 Jun 2019 11:38:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190621113834eusmtrp26d85d232913e911675c32e88f2683bd4~qM76cRvHs2023820238eusmtrp2G;
        Fri, 21 Jun 2019 11:38:34 +0000 (GMT)
X-AuditID: cbfec7f4-113ff70000001119-a9-5d0cc1bb8b12
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F1.6E.04146.AB1CC0D5; Fri, 21
        Jun 2019 12:38:34 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190621113834eusmtip2ce1bedd2f35f00d7d04f229296d8a84c~qM76HR9ns1652116521eusmtip2y;
        Fri, 21 Jun 2019 11:38:34 +0000 (GMT)
Subject: Re: [PATCH] efifb: BGRT: Add check for new BGRT status field
 rotation bits
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Jones <pjones@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <82a83a92-a99f-520c-921f-3f7b57f5bebf@samsung.com>
Date:   Fri, 21 Jun 2019 13:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7q7D/LEGuyZJGHx/8NuRosrX9+z
        Wbw5Pp3Jou3hLUaLE30fWC26Ft5gd2DzuHNtD5vH/e7jTB7v911l8/i8SS6AJYrLJiU1J7Ms
        tUjfLoEro20WS8ExgYptsz6wNjD283YxcnBICJhIdD/J62Lk4hASWMEocaPtHCOE84VRYu/j
        t1DOZ0aJ20tvMXcxcoJ1rPh7FyqxnFHi8ZH1TBDOW0aJDVta2UCqhAVCJfatPAJmiwioS0zt
        6GEDKWIGKTpx7BULSIJNwEpiYvsqRpBDeAXsJC7NDgQJswioSqzuX8UKYosKREjcP7YBzOYV
        EJQ4OfMJWCsnUPnkGTfA5jMLiEvcejKfCcKWl2jeOhvq0mXsEke/ckPYLhLTZkxngrCFJV4d
        38IOYctI/N85H+wBCYF1jBJ/O14wQzjbGSWWT/7HBlFlLXH4+EVWkEOZBTQl1u/Shwg7Svyf
        +JEZEpB8EjfeCkLcwCcxadt0qDCvREebEES1msSGZRvYYNZ27VzJPIFRaRaSz2Yh+WYWkm9m
        IexdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzDZnP53/MsOxl1/kg4xCnAwKvHw
        HpjFHSvEmlhWXJl7iFGCg1lJhJcnhydWiDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0
        xJLU7NTUgtQimCwTB6dUA6PJht8tNZJ5wnsyWF9tqykUbq79Kn3EIeJn59LvHH8+1uu+2t/M
        dvnwNMlnSvcD4vamXt5+eMmHezXd286c8JVMuG1tY5ix4N8BgcKyjnaHkql1ebdjHnfwR5bP
        XMmyq1F6T3Dno/98nhxcly/xz0xiNNvH/Wtz+IrL2/nerlZYK//1VOL2gH4lluKMREMt5qLi
        RADlL8LMMgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xe7q7DvLEGnzZrGDx/8NuRosrX9+z
        Wbw5Pp3Jou3hLUaLE30fWC26Ft5gd2DzuHNtD5vH/e7jTB7v911l8/i8SS6AJUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo20WS8ExgYptsz6w
        NjD283YxcnJICJhIrPh7l7GLkYtDSGApo8SHjt8sXYwcQAkZiePryyBqhCX+XOtiA7GFBF4z
        SnztUASxhQVCJe4/+sMEYosIqEtM7ehhA5nDLPCWUeLa129QDWeZJN5NswSx2QSsJCa2r2IE
        mc8rYCdxaXYgSJhFQFVidf8qVhBbVCBC4sz7FSwgNq+AoMTJmU/AbE6g8skzboCNZAba9Wfe
        JWYIW1zi1pP5TBC2vETz1tnMExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjK1tx35u3sF4aWPwIUYBDkYlHt4Ds7hjhVgTy4orcw8xSnAwK4nw8uTwxArx
        piRWVqUW5ccXleakFh9iNAV6biKzlGhyPjDu80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MCouNmnmWWzHO8HqkY/N1bPTP0VxdV4NN1nQaGScxucczMGy7b9K
        wOk3nnol5YZmmpPTGKsOyS3Ksu4U+vgiprFoWX/0oxgeh9/FP292PSxVbZPKd+PR7Z/m8yki
        4Nuv/roFnG/2NVdFnAv4USRouasqe719sNoVrsU8LZ2/lixWlrmvNOOkEktxRqKhFnNRcSIA
        0dqWSMMCAAA=
X-CMS-MailID: 20190621113834eucas1p1ef78d2bdf1a2a47ebfaa35f6f01f0bd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190611142502epcas2p35cbca6e4ef78d061a631012f0ca5d49a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190611142502epcas2p35cbca6e4ef78d061a631012f0ca5d49a
References: <20190529154635.2659-1-hdegoede@redhat.com>
        <CAKv+Gu8bLcDROFNFfqHaN1Z+EK5bnXMNDSJbBK-pCmq5XP_kBw@mail.gmail.com>
        <CAKv+Gu8w2Vj-AS-cfaB8cms+ZJ7qppS-Du_334_xm51rz0CYsA@mail.gmail.com>
        <CGME20190611142502epcas2p35cbca6e4ef78d061a631012f0ca5d49a@epcas2p3.samsung.com>
        <3065d32f-add7-4e48-164b-c248cc116cea@redhat.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


On 6/11/19 4:24 PM, Hans de Goede wrote:
> Hi,
> 
> On 11-06-19 16:04, Ard Biesheuvel wrote:
>> On Mon, 10 Jun 2019 at 17:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>
>>> On Wed, 29 May 2019 at 17:46, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
>>>> reserved. These bits are now used to indicate if the image needs to be
>>>> rotated before being displayed.
>>>>
>>>> The efifb code does not support rotating the image before copying it to
>>>> the screen.
>>>>
>>>> This commit adds a check for these new bits and if they are set leaves the
>>>> fb contents as is instead of trying to use the un-rotated BGRT image.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>
>>
>> BTW should we make sure that this patch and the efi-bgrt patch get
>> merged at the same time?
> 
> The 2 patches are related but merging them at the same time is not
> necessary.
> 
>> I guess the net result is just that we get
>> rid of some error in the log, but a rotated BMP will be ignored
>> otherwise.
> 
> Right, worse case (if the bmp fits pre-rotation) it will be displayed
> rotated. Note on the one machine I'm aware of which uses these bits
> the bmp does not fit pre-rotation, so we end up triggering:
> 
> error:
>         memunmap(bgrt_image);
>         pr_warn("efifb: Ignoring BGRT: unexpected or invalid BMP data\n");
> }
> 
> Which this patch replaces with hitting:
> 
>         if (bgrt_tab.status & 0x06) {
>                 pr_info("efifb: BGRT rotation bits set, not showing boot graphics\n");
>                 return;
>         }
> 
> Instead. So at least on the one machine I know of this is 99% cosmetic.
> 
>> Or is it relevant for userland in some other way?
> 
> No.
> 
> Regards,
> 
> Hans

Patch queued for v5.3, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
