Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A34DEC9FD
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2019 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfKAU45 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Nov 2019 16:56:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48997 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfKAU45 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 1 Nov 2019 16:56:57 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.55.45])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA1Ku1Hi3597880
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 1 Nov 2019 13:56:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA1Ku1Hi3597880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572641763;
        bh=3An007NMR3t5lhDsOPVJ9K0dkZrEaxbrM0ul5cfaPa4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kC/rRorYzspNXKHbAH3qWGpvmB1CgN+djkae1LWKmc8pl5Ljhbbx+OZuXSlpKJreR
         EtmIjUtI1/wXaD16smKcAatpd3ZUb8CuJ/ILid1PZ2Djqz0Qx0r6nOFq8dQOwkznxf
         meW8aP0YNx/p8Q2yGS61OPbIZg9oM3EASsRzsoYDoHaVVnQRdA+c+cCtFu5850FuJR
         D526P2FtSBEK7HnfjwYPQsBOcJrcpTFR7lxr9RQkbnCcQTcPgVXF6iTqho0EyR/+Sw
         IHfFNPB1eD3Mt7/NSMPdZojleTYu7yXr2Ti9Qo4IPDL30WRUfLF98uXYQNLpUGPHjs
         ePcOqSIqHfEDg==
Subject: Re: [PATCH v4 2/3] x86/boot: Introduce the kernel_info.setup_type_max
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        jgross@suse.com, kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        mingo@redhat.com, rdunlap@infradead.org, ross.philipson@oracle.com,
        tglx@linutronix.de
References: <20191024114814.6488-1-daniel.kiper@oracle.com>
 <20191024114814.6488-3-daniel.kiper@oracle.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <e094a1cf-6bf2-1e8a-94c7-47767d66138e@zytor.com>
Date:   Fri, 1 Nov 2019 13:55:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191024114814.6488-3-daniel.kiper@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2019-10-24 04:48, Daniel Kiper wrote:
> This field contains maximal allowed type for setup_data.
> 
> Now bump the setup_header version in arch/x86/boot/header.S.

Please don't bump the protocol revision here, otherwise we would create
a very odd pseudo-revision of the protocol: 2.15 without SETUP_INDIRECT
support, should patch 3/3 end up getting reverted.

(It is possible to detect, of course, but I feel pretty sure in saying
that bootloaders won't get it right.)

Other than that:

Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>

	-hpa
