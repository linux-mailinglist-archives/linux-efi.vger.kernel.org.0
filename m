Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A850C25E4C5
	for <lists+linux-efi@lfdr.de>; Sat,  5 Sep 2020 02:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgIEA6F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 20:58:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgIEA6F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Sep 2020 20:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599267483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNBOhuEZgb11jNzVin4vW86ugipWCO8mBgoUlZPaXM0=;
        b=i6gn08PEoU5xuO+NBHdc2FEx5RAo9Kv1DxZ2bfIQKzaBFXGECy6e0x2DtMoAoZ5tebTWs0
        y4eSh51Io7Bn3BwR1XnD0w978S1r63Ilca/0B/JKeDG7XW0QQ8lNoWwtUZj1e3tdw1quvm
        Upb+wcSyhQdkuf14L/m2dWAvO03Vthc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-uF9XtEZ6OV2bD6ZgtSTOhQ-1; Fri, 04 Sep 2020 20:58:01 -0400
X-MC-Unique: uF9XtEZ6OV2bD6ZgtSTOhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF211DDEA;
        Sat,  5 Sep 2020 00:57:59 +0000 (UTC)
Received: from [10.10.65.66] (ovpn-65-66.rdu2.redhat.com [10.10.65.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ADE3460C05;
        Sat,  5 Sep 2020 00:57:57 +0000 (UTC)
Subject: Re: [PATCH 2/3] integrity: Move import of MokListRT certs to a
 separate routine
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Jones <pjones@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
References: <20200826034455.28707-1-lszubowi@redhat.com>
 <20200826034455.28707-3-lszubowi@redhat.com>
 <CAHp75Vec0a3LC7dGY6wacQu0brc+Zjfowt6kGdcZ9sfMzoDR9g@mail.gmail.com>
From:   Lenny Szubowicz <lszubowi@redhat.com>
Message-ID: <ada8f771-5717-58f1-8352-feffea8703b4@redhat.com>
Date:   Fri, 4 Sep 2020 20:57:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vec0a3LC7dGY6wacQu0brc+Zjfowt6kGdcZ9sfMzoDR9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/2/20 3:55 AM, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 6:45 AM Lenny Szubowicz <lszubowi@redhat.com> wrote:
>>
>> Move the loading of certs from the UEFI MokListRT into a separate
>> routine to facilitate additional MokList functionality.
>>
>> There is no visible functional change as a result of this patch.
>> Although the UEFI dbx certs are now loaded before the MokList certs,
>> they are loaded onto different key rings. So the order of the keys
>> on their respective key rings is the same.
> 
> ...
> 
>>   /*
>> + * load_moklist_certs() - Load MokList certs
>> + *
>> + * Returns:    Summary error status
>> + *
>> + * Load the certs contained in the UEFI MokListRT database into the
>> + * platform trusted keyring.
>> + */
> 
> Hmm... Is it intentionally kept out of kernel doc format?

Yes. Since this is a static local routine, I thought that it
shouldn't be included by kerneldoc. But I wanted to generally adhere
to the kernel doc conventions for a routine header. To that end,
in V2 I move the "Return:" section to come after the short description.

> 
>> +static int __init load_moklist_certs(void)
>> +{
>> +       efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
>> +       void *mok = NULL;
>> +       unsigned long moksize = 0;
>> +       efi_status_t status;
>> +       int rc = 0;
> 
> Redundant assignment (see below).
> 
>> +       /* Get MokListRT. It might not exist, so it isn't an error
>> +        * if we can't get it.
>> +        */
>> +       mok = get_cert_list(L"MokListRT", &mok_var, &moksize, &status);
> 
>> +       if (!mok) {
> 
> Why not positive conditional? Sometimes ! is hard to notice.
> 
>> +               if (status == EFI_NOT_FOUND)
>> +                       pr_debug("MokListRT variable wasn't found\n");
>> +               else
>> +                       pr_info("Couldn't get UEFI MokListRT\n");
>> +       } else {
>> +               rc = parse_efi_signature_list("UEFI:MokListRT",
>> +                                             mok, moksize, get_handler_for_db);
>> +               if (rc)
>> +                       pr_err("Couldn't parse MokListRT signatures: %d\n", rc);
>> +               kfree(mok);
> 
>   kfree(...)
>   if (rc)
>    ...
>   return rc;
> 
> And with positive conditional there will be no need to have redundant
> 'else' followed by additional level of indentation.
> 
>> +       }
> 
>> +       return rc;
> 
> return 0;
> 
>> +}
> 
> P.S. Yes, I see that the above was in the original code, so, consider
> my comments as suggestions to improve the code.
> 

I agree that your suggestions improve the code. I've incorporated this
into V2.

                        -Lenny.

