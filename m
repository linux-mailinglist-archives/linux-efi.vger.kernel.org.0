Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59407042B2
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 03:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjEPBMW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 21:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEPBMD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 21:12:03 -0400
Received: from sender3-of-o58.zoho.com (sender3-of-o58.zoho.com [136.143.184.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081461B6
        for <linux-efi@vger.kernel.org>; Mon, 15 May 2023 18:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684199480; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=MBzvm1i6w5sH9qB90XtoDWPnzsiAxVMUrAquePUtEQUay8xbP0iEIehH0iPtU12UTXFc28TsN9kguT53KvIFyS3QxYQLKSq/b/VvZX/9+gxbOveV0vrFfiX9SsUZ/xXRBZcDJeo3y0/s458GrjtaGfZep0soRKQ/1gYW0nUMwgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684199480; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=3D1ZcgeS6gbmfb74g6qO4yIjzREqLwPUB74IkVK5hiE=; 
        b=YF0ONQkmYu/eFV5tXlTxRET1MLUVYXbWjX/NIjEFLhR0ptkGKcf8OYNw05swr0LDdSVxPgil0QL3EW1H/Q7c+oGqLvutx5KVN/307co3cHGAEemhiLb2ky5VGvxbCGTjIuy085hZqgkaqUxhn/E/Kgz399vEdGjVysdZRytYeDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684199480;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=3D1ZcgeS6gbmfb74g6qO4yIjzREqLwPUB74IkVK5hiE=;
        b=eF0JQ9HC29IQT8CAesMjHLcuTjhmoFhWidAgpxW3cr1t79/ekq1bo+RHa/KvmrCe
        5CkfzqSd3qdahwWqDR0UCseja3klsydvIUs4gvHt5/jhTfSQx+HsVi651NXwAbQo2G/
        z41V1Az7BhP9riZUaoopJicuZsK4Yg7xxfBeBGww=
Received: from [10.10.1.128] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1684199478060628.8578234862518; Mon, 15 May 2023 18:11:18 -0700 (PDT)
Message-ID: <7ff17d2b-7030-fbbd-c495-b43583e3f9e7@apertussolutions.com>
Date:   Mon, 15 May 2023 21:11:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To:     Ross Philipson <ross.philipson@oracle.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        ardb@kernel.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
 <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 12:17, Ross Philipson wrote:
> On 5/12/23 07:26, Matthew Garrett wrote:
>> On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:
>>
>>> +static void sl_find_event_log(struct slr_table *slrt)
>>
>> If this is called after the EFI stub then we're presumably
>> post-ExitBootServices and we're copied the TPM event log into a
>> configuration table so it's available to the runtime kernel. That also
>> means that we should be adding all further measurements to the Final
>> Events Table rather than the initial event log. How's that handled here,
>> both in terms of ensuring further events (generated by firmware or by
>> us) get added to the right place, and in terms of ensuring the event
>> logs the kernel has later on were covered appropriately? Or is the SL
>> event log an entirely different thing that can be merged in later
>> because it only covers the DRTM PCRs?
> 
> This is a good point. At this point it is really something we 
> overlooked. We will have to revisit this and figure out the best way to 
> find the final event log depending on how things booted.

I believe Ross misunderstood what you were asking for here. There are 
two reasons this is not possible or desired. The first reason is that on 
Intel, the DRTM log is not initialized by TrenchBoot code in the 
preamble. It is only responsible for allocating a buffer and recording 
the location in the TXT structures. When the SINIT ACM is executed, it 
will initialize the log and record the measurement that CPU sent 
directly to the TPM and then the measurements the ACM makes of the 
environment. If you pointed at the SRTM log, then the ACM would write 
over existing log, which I don't think you want. Now if you pointed at 
the tail end of the SRTM log, you would still end up with a second, 
separate log that just happens to be memory adjacent. The second reason 
is more from a trusted computing perspective, these are two different 
trust chains starting from two different Roots of Trust reflecting two 
different temporal states of the system, i.e. freshness. Typically this 
is were most will point out the need to have a measure of the resident 
firmware, i.e. SMM. To address that, should Intel to publish the spec 
for interacting with PPAM[1], TrenchBoot will be able to finally close 
the SMM gap, giving runtime validation of SMM.

[1] 
https://www.intel.com/content/dam/www/central-libraries/us/en/documents/drtm-based-computing-whitepaper.pdf

v/r,
dps
