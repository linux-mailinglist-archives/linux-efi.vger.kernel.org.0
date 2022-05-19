Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D1252DED9
	for <lists+linux-efi@lfdr.de>; Thu, 19 May 2022 22:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbiESU7Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 May 2022 16:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiESU7Y (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 May 2022 16:59:24 -0400
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BEEC3DD;
        Thu, 19 May 2022 13:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1652993938; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RiZQ0ZOTCial1OVArSdR7fF+wyx602CWnh9upFkwMOgiN5jQmc7ShQ7vWR2Wn4SEJ+ssuf1sS1/SPG7Z5AAH9/WoPz5tBjXfHjPorALtLNtbEQ3bMHdsD4+RiQs+J6zbLw7mOpz8ooiFpPwZr7hFlL6HikEpTAh3jX0Mzhr1fJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1652993938; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+lxcsbkWlW5OwDAWmQ8OTx1rv/aXJYWx9gMImQtgn8Q=; 
        b=GOHuI5g9gHB4MCyQoxHacvW+aswhr5onkesYg+TC7HaCt5vjIPs2gt3tKwPfPlFJrYWRxYj8gbNOuAhDPOePwV6WEBasjV6WAo8DgvUQ/qmS7WHpDM9h0etJhCRu/Ym3Fgv1yQSJfjB3P82bZr3sh6dWp0+xFTCrD6RvmcY9pv0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1652993938;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:From:From:Subject:Subject:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=+lxcsbkWlW5OwDAWmQ8OTx1rv/aXJYWx9gMImQtgn8Q=;
        b=rlYFZ24nM6N02tt/RhCI30K/UlgCtuaE+iIC4nQ6cTV/EsnpMIWUgJ2tmYWAYaYt
        2SG20ToIvS5VQGiOEVw/Rs4GxsiUUxjbMg3PxrigsY8bkkqc/8GFj8tPaaakj6SPW42
        8JnHonQc99bESroQHYUwJLiNhY/caMg0ViTQ68mc=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1652993933360319.6557389531473; Thu, 19 May 2022 13:58:53 -0700 (PDT)
Message-ID: <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
Date:   Thu, 19 May 2022 16:57:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Daniel Kiper <daniel.kiper@oracle.com>
Cc:     Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grub-devel@gnu.org, James Morris <jmorris@namei.org>
References: <20220329174057.GA17778@srcf.ucam.org>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: Linux DRTM on UEFI platforms
In-Reply-To: <20220329174057.GA17778@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


Greetings,

Based on the discussions that occurred in this thread, there seems to be
two issues at hand that should be decoupled, as their solutions can and
should be implemented independently. These are:
- the handling of the Dynamic Launch preamble
- providing the complete kernel configuration for measurement

For the former, it is believed there is a consensus that Matthew's
proposed callback approach would be the preferred method. Through some
contemplating and prototyping, the determination is that this will in
fact be an approach that will ultimately benefit the TrenchBoot project
itself.

In general, the preamble consists of two activities: 1. preparing the
contents in memory and 2. preparing the hardware in order to call the
Dynamic Launch instruction. In past implementations, these two
activities were conducted sequentially, but in reality the time delta
between the two may be arbitrary. Introducing this separation does not
introduce any security concerns due to how the Dynamic Launch works. Any
tampering of the contents in memory will either cause the Dynamic Launch
to fail or result in a detectable difference in the Dynamic Launch
measurement chain.

In order to separate the hardware interactions into what will be called
the DLE Handler, this will require a collection of information regarding
how the environment is set up. When working through what would be
required, this led to the realization that this really should be
generalized into a formal specification for TrenchBoot's Secure Launch.
This will enable a reusable solution for the TrenchBoot project, versus
implementing a one-off solution for Linux. A prototype of is near
completion, for which below is a visual depiction along with a
step-by-step walk through of how it would work for efi-stub.

Secure Launch Flow:

                         +-----------------+
                         |                 |
         +-------------->| Secure Launch   +---------------+
         |               | Resource Table  |               |
         |               |                 |    +------|---------------+
         |               +--------+--------+    |      |         DLME  |
         |                        |             |      v               |
         |                        |             | +---------------+    |
   +-----+---------+              v             | |               |    |
+--+-------------+ |       +-------------+      | | Secure Launch |    |
|                | +------>|             +------->|     Entry     |    |
| Bootloader(s)  | |       | DLE Handler |      | |               |    |
|                +-+       |             |      | +---------------+    |
+----------------+         +-------------+      +----------------------+

A quick note on the flow diagram, for simplicity all entities prior to
the DLE Handler are represented by the "Bootloader(s)" block due to the
fact that what entities are involved can and will vary. This is where
both GRUB and efi-stub are being represented even though for Linux EFI,
GRUB is considered the bootmanager while efi-stub is the bootloader.

An efi-stub walk-thru:

1. - GRUB
1.1 - GRUB will initialize the Secure Launch Resource Table (SLRT)
1.2 - GRUB will set up DLE Handler and register it in SLRT
1.5 - GRUB will load Linux kernel
1.3 - GRUB will set up DL environment appropriately for HW platform
1.4 - GRUB will record DL setup in SLRT
1.5 - GRUB will record SLRT location in platform's DL config structure
1.5 - GRUB will register SLRT in EFI configuration table under SL GUID
1.6 - GRUB will invoke efi-stub

2. - efi-stub
2.1 - efi-stub will check if SL GUID is in EFI configuration table
2.2 - for each efi-stub config action, an SLRT EFI config event will be
      recorded
2.3 - efi-stub calls EBS() then jumps to DLE Handler registered in SLRT
      while passing the SLRT address

3. - DL Handler
3.1 - DL Handler will retrieve SL Entry from SLRT
3.2 - DL Handler will prepare HW for calling DL CPU instruction
3.3 - DL Handler will execute DL CPU instruction

4. SL Entry
4.1 SL Entry will retrieve SLRT address from platform's DL config struct
4.2 SL Entry will use policy in SLRT to determine what to measure
4.3 SL Entry will set up HW to what Linux expects
4.4 SL Entry will jump into Linux setup kernel
4.5 SL Entry will record measurements into TPM prior to init process
    starting

While Matthew's original proposal was around having a location in the
efi-stub for the callback to be registered, it is felt that it would be
better suited as part of the Secure Launch specification. What is
proposed is for the address of the DL Handler to be stored in the SLRT,
details for the SLRT are below. Then the bootloader that is responsible
for loading the DL Handler will register the SLRT in the EFI
configuration table. Checking for the SLRT GUID in the EFI configuration
table will enable the EFI bootoader responsible for calling EBS, in this
case efi-stub, to know that a Dynamic Launch has been requested. It also
seems this would be more in line with how EFI tends to work, versus a
Linux-specific callback boot param or something similar.

Hopefully this resolves the first of the two issues mentioned at the
beginning of this email in a manner that addresses most of the concerns
raised in the earlier discussions. This leaves the second issue over how
to get an accurate measurement of how the kernel was configured by
efi-stub. When reviewing the comments in the discussion, it was realized
the originally requested approach was in fact in reverse. Instead of
asking for efi-stub's internal API/ABI to be documented, Secure Launch
should specify an ABI for how any bootloader should be invoking a Secure
Launch entrypoint, particularly capturing how an EFI bootloader
configured the environment. This is the second motivation for devising
the SLRT. Specifying this ABI also provided the opportunity to
incorporate a measurement policy and thus allowing for it to be
separated away from sl-stub, as it is in the current implementation. For
this discussion the focus will be on the portions of the SLRT relating
to EFI Environments and in particular the EFI config event record
mentioned in step 2.2 of the efi-stub walk-thru.

First, a short review of what the Secure Launch Resource Table is and
its purpose. The SLRT is to provide a platform and kernel agnostic
configuration table of the meta-data pertinent to the Secure Launch
entry points for the variety of kernels the TrenchBoot project will be
seeking to support. The specification for the table is in progress, but
the consensus is that it will consist of a header structure followed by
a packed series of TLV records. The specification will describe the
various types of records, but the ones of interests in this discussion
are those that efi-stub would use to record how it configured the
environment.

The initially proposed TLV record, see below, for EFI configuration
information was devised around allowing an EFI bootloader to save
multiple config events under a single TLV record. In discussions on the
specification thus far, there are questions if it would be better to
have a TLV record for each config event or the proposed multiple events
per TLV record. It is worth noting that an assumption is being made in
the proposed record. The assumption is that a config event will either
be setting a configuration value between 1 and 8 bytes, or it will be a
data blob for which the address and size will be recorded. The question
is whether that covers all actions the efi-stub does or expects that it
will have to do in the near future.

struct slrt_entry_efi_config_event {
        struct slrt_entry_hdr hdr;
        uint32_t identifier;                /* EFI bootloader ID */
        uint16_t reserved;
        uint16_t nr_entries;                /* Num cfg records */
        struct efi_cfg_value values[0];     /* Array of cfg values */
    };

    struct efi_cfg_value {
        uint64_t data;          /* cfg data (address or value) */
        uint32_t size;          /* data size if data is an addr */
        uint32_t flags;         /* 1L<0 IS_ADDR: data is an addr */
        char evt_info[8];       /* event info str for TPM event log */
    };

Hopefully the general approach here is agreeable, as IMHO it does
provide a fairly elegant approach to resolving the issues at hand.
Details can always be negotiated to address various implementation
concerns. Provided this is acceptable, then everyone here is welcome to
provide input on the Secure Launch specification, link forthcoming.

V/r,
Daniel P. Smith
Apertus Solutions, LLC
