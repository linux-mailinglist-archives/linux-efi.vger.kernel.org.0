Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E57126629C
	for <lists+linux-efi@lfdr.de>; Fri, 11 Sep 2020 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIKPy0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 11 Sep 2020 11:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36128 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726570AbgIKPyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 11 Sep 2020 11:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599839661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrqEMuNv+1C+Q9u81rRR/J9O4s8lK0dAQz/GWPxtPKI=;
        b=D2/WhwDEkFot3uOOIx4Dre8gllxBKcEyT9wxYv5Yh3u2kX+F2jIgWFT3xQBkmyY1nzILxk
        embxXiUZ4/bPqMmNyShc427HDKvHSJKxk2Gem2s/a6cewc0dT7z42BxxWfXSP4iAWEbLN4
        y83VfM3UkFophhziIkjP2qbI9dZaVs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-QWYnVU4QPqOTAx6UqlvlNQ-1; Fri, 11 Sep 2020 11:54:17 -0400
X-MC-Unique: QWYnVU4QPqOTAx6UqlvlNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44CFC801AC4;
        Fri, 11 Sep 2020 15:54:14 +0000 (UTC)
Received: from [10.10.110.42] (unknown [10.10.110.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86AD375125;
        Fri, 11 Sep 2020 15:54:11 +0000 (UTC)
Subject: Re: [PATCH V2 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-security-module@vger.kernel.org, andy.shevchenko@gmail.com,
        James Morris <jmorris@namei.org>, serge@hallyn.com,
        Kees Cook <keescook@chromium.org>, zohar@linux.ibm.com,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>, prarit@redhat.com
References: <20200905013107.10457-1-lszubowi@redhat.com>
 <20200905013107.10457-3-lszubowi@redhat.com>
 <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <f0a079b1-5f02-8618-fdfe-aea2278113c9@redhat.com>
Date:   Fri, 11 Sep 2020 11:54:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEdkdeE8VSZqEzhd__Kb7_ZmG2af6iBpbY3=nsj1-phYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/11/20 11:02 AM, Ard Biesheuvel wrote:
> On Sat, 5 Sep 2020 at 04:31, Lenny Szubowicz <lszubowi@redhat.com> wrote:
>>
>> Move the loading of certs from the UEFI MokListRT into a separate
>> routine to facilitate additional MokList functionality.
>>
>> There is no visible functional change as a result of this patch.
>> Although the UEFI dbx certs are now loaded before the MokList certs,
>> they are loaded onto different key rings. So the order of the keys
>> on their respective key rings is the same.
>>
>> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> 
> Why did you drop Mimi's reviewed-by from this patch?

It was not intentional. I was just not aware that I needed to propagate
Mimi Zohar's reviewed-by from V1 of the patch to V2.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

V2 includes changes in that patch to incorporate suggestions from
Andy Shevchenko. My assumption was that the maintainer would
gather up the reviewed-by and add any signed-off-by as appropriate,
but it sounds like my assumption was incorrect. In retrospect, I
could see that having the maintainer dig through prior versions
of a patch set for prior reviewed-by tags could be burdensome.

Advice on the expected handling of this would be appreciated.

                     -Lenny.

> 
>> ---
>>   security/integrity/platform_certs/load_uefi.c | 63 +++++++++++++------
>>   1 file changed, 44 insertions(+), 19 deletions(-)
>>
>> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
>> index 253fb9a7fc98..c1c622b4dc78 100644
>> --- a/security/integrity/platform_certs/load_uefi.c
>> +++ b/security/integrity/platform_certs/load_uefi.c
>> @@ -66,6 +66,43 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>>   }
>>
>>   /*
>> + * load_moklist_certs() - Load MokList certs
>> + *
>> + * Load the certs contained in the UEFI MokListRT database into the
>> + * platform trusted keyring.
>> + *
>> + * Return:     Status
>> + */
>> +static int __init load_moklist_certs(void)
>> +{
>> +       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
>> +       void *mok;
>> +       unsigned long moksize;
>> +       efi_status_t status;
>> +       int rc;
>> +
>> +       /* Get MokListRT. It might not exist, so it isn't an error
>> +        * if we can't get it.
>> +        */
>> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>> +       if (mok) {
>> +               rc = parse_efi_signature_list("UEFI:MokListRT",
>> +                                             mok, moksize, get_handler_for_db);
>> +               kfree(mok);
>> +               if (rc)
>> +                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
>> +               return rc;
>> +       }
>> +       if (status == EFI_NOT_FOUND)
>> +               pr_debug("MokListRT variable wasn't found\n");
>> +       else
>> +               pr_info("Couldn't get UEFI MokListRT\n");
>> +       return 0;
>> +}
>> +
>> +/*
>> + * load_uefi_certs() - Load certs from UEFI sources
>> + *
>>    * Load the certs contained in the UEFI databases into the platform trusted
>>    * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
>>    * keyring.
>> @@ -73,17 +110,16 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
>>   static int __init load_uefi_certs(void)
>>   {
>>          efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
>> -       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
>> -       void *db = NULL, *dbx = NULL, *mok = NULL;
>> -       unsigned long dbsize = 0, dbxsize = 0, moksize = 0;
>> +       void *db = NULL, *dbx = NULL;
>> +       unsigned long dbsize = 0, dbxsize = 0;
>>          efi_status_t status;
>>          int rc = 0;
>>
>>          if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
>>                  return false;
>>
>> -       /* Get db, MokListRT, and dbx.  They might not exist, so it isn't
>> -        * an error if we can't get them.
>> +       /* Get db and dbx.  They might not exist, so it isn't an error
>> +        * if we can't get them.
>>           */
>>          if (!uefi_check_ignore_db()) {
>>                  db = get_cert_list(L"db", &secure_var, &dbsize, &status);
>> @@ -102,20 +138,6 @@ static int __init load_uefi_certs(void)
>>                  }
>>          }
>>
>> -       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
>> -       if (!mok) {
>> -               if (status == EFI_NOT_FOUND)
>> -                       pr_debug("MokListRT variable wasn't found\n");
>> -               else
>> -                       pr_info("Couldn't get UEFI MokListRT\n");
>> -       } else {
>> -               rc = parse_efi_signature_list("UEFI:MokListRT",
>> -                                             mok, moksize, get_handler_for_db);
>> -               if (rc)
>> -                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
>> -               kfree(mok);
>> -       }
>> -
>>          dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
>>          if (!dbx) {
>>                  if (status == EFI_NOT_FOUND)
>> @@ -131,6 +153,9 @@ static int __init load_uefi_certs(void)
>>                  kfree(dbx);
>>          }
>>
>> +       /* Load the MokListRT certs */
>> +       rc = load_moklist_certs();
>> +
>>          return rc;
>>   }
>>   late_initcall(load_uefi_certs);
>> --
>> 2.27.0
>>
> 

