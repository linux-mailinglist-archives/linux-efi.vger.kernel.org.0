Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7207CFEC0
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfJHQQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 12:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727514AbfJHQQD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Oct 2019 12:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570551362;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMCrrylCRmBl2ci0sro7S3+VKpru5MCXIR/yx7hpz7Q=;
        b=G+p3glVeC+O+Wq3kLSGvwkpX0REj+c8XsxKFE/7H1DVJNrhkTmZKUsRAFQ+KC3/cGAwtSX
        QJ4R1Qn8vDLqcEbjvuXB9YEvoDC3p6pYDhOpZGnOH2Sswjj6wwDTwD3Q4mQ0B0voAY8vNu
        B0AP31JpHyLSl4rMGvdps3CIzpqDZlA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-7D4QC2VyMzW4cHnUStAKTQ-1; Tue, 08 Oct 2019 12:15:56 -0400
Received: by mail-io1-f72.google.com with SMTP id u18so33820234ioc.4
        for <linux-efi@vger.kernel.org>; Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ou0tS7RrxGwJYbkv5P7tqtmWszS5GQLWwcSoY8Uzr/4=;
        b=b5RgKDkNPXxfp4cqINBnl6xiEiV3Cb9qGGPUkO4FJi2Li8p3vwv0ujnmQCGx6nFEiL
         YMCy2xToOvn9qoWW/76GuBxYO0XsCuA1aeiq1svE1fysRAf6qD8p8jFqAU10LMOSLYpt
         u55UmAKjMAqVpwIxZ65XkCTnhDW2tWkadsERw557W5HI+GsMISNc04UefVkZ9aOm+UKp
         xtsdsjC0hpVOgi8ybcRbXp+nAA0CmKrYrPX5dU356JuZcSKovJJPgy1qb3+S9lyw2iWP
         oG2Tc/zUsgbFbsv5xli215MFbYUQLWOPc5iN9+WUue3rvzqWrdUrrjSFrmW225DITqX5
         2fOA==
X-Gm-Message-State: APjAAAUhiutTmw/kTog+va6HdqEw0xjLw9Y8Cla7RCmHEwHV8NGJn8U8
        lUPlsqKQKXAVoeT7Wm/9PHfLaiT5101YT6XvUt+aZmzgxq9llOgqhZ9bEmqcuTLPzOIV0BttRkW
        36P+9zQBBwr9/ZOuR222Q
X-Received: by 2002:a5d:8ac4:: with SMTP id e4mr5793639iot.185.1570551355515;
        Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0+hoB1v72LiMOycxhZcE17wVcnSgjBHNmFhBxaa0wEB6Fdy7656PMyUlh6rq7awUIB1D8Bg==
X-Received: by 2002:a5d:8ac4:: with SMTP id e4mr5793615iot.185.1570551355314;
        Tue, 08 Oct 2019 09:15:55 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id c8sm9338443ile.9.2019.10.08.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 09:15:54 -0700 (PDT)
Date:   Tue, 8 Oct 2019 09:15:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] efi/tpm: fix sanity check of unsigned tbl_size
 being less than zero
Message-ID: <20191008161553.qls5lbyaxlasw25v@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191008100153.8499-1-colin.king@canonical.com>
 <20191008114559.GD25098@kadam>
MIME-Version: 1.0
In-Reply-To: <20191008114559.GD25098@kadam>
User-Agent: NeoMutt/20180716
X-MC-Unique: 7D4QC2VyMzW4cHnUStAKTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue Oct 08 19, Dan Carpenter wrote:
>On Tue, Oct 08, 2019 at 11:01:53AM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Currently the check for tbl_size being less than zero is always false
>> because tbl_size is unsigned. Fix this by making it a signed int.
>>
>> Addresses-Coverity: ("Unsigned compared against 0")
>> Fixes: e658c82be556 ("efi/tpm: Only set 'efi_tpm_final_log_size' after s=
uccessful event log parsing")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/firmware/efi/tpm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index 703469c1ab8e..ebd7977653a8 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -40,7 +40,7 @@ int __init efi_tpm_eventlog_init(void)
>>  {
>>  =09struct linux_efi_tpm_eventlog *log_tbl;
>>  =09struct efi_tcg2_final_events_table *final_tbl;
>> -=09unsigned int tbl_size;
>> +=09int tbl_size;
>>  =09int ret =3D 0;
>
>
>Do we need to do a "ret =3D tbl_size;"?  Currently we return success.
>It's a pitty that tpm2_calc_event_log_size() returns a -1 instead of
>-EINVAL.
>
>regards,
>dan carpenter
>

perhaps "ret =3D -EINVAL;"? Currently nothing checks the return value of ef=
i_tpm_eventlog_init though.

