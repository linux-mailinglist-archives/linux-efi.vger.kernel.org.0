Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374F1F77C6
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jun 2020 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFLMQU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-efi@lfdr.de>); Fri, 12 Jun 2020 08:16:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLMQU (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 12 Jun 2020 08:16:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F7FCAC12;
        Fri, 12 Jun 2020 12:16:22 +0000 (UTC)
From:   Fabian Vogt <fvogt@suse.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        =?ISO-8859-1?Q?Lo=EFc?= Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] tpm: verify that it's actually an event log header before parsing
Date:   Fri, 12 Jun 2020 14:16:17 +0200
Message-ID: <88447091.GpfeQiP6xL@linux-e202.suse.de>
In-Reply-To: <6807898.V3K9nM3qbd@linux-e202.suse.de>
References: <1894249.ujS34B1uSo@linux-e202.suse.de> <CAMj1kXHErV-tx+8GvvLmb-L0wXq1cVwzY+OEr4PEHDZWrB7Dpg@mail.gmail.com> <6807898.V3K9nM3qbd@linux-e202.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Freitag, 12. Juni 2020, 13:58:51 CEST schrieb Fabian Vogt:
> Am Freitag, 12. Juni 2020, 13:01:33 CEST schrieb Ard Biesheuvel:
> > On Fri, 5 Jun 2020 at 16:22, Fabian Vogt <fvogt@suse.de> wrote:
> > >
> > > It's possible that the first event in the log is not actually a log
> > > header at all, but rather a normal event. This leads to the cast in
> > > __calc_tpm2_event_size being an invalid conversion, which means that
> > > the values read are effectively garbage. Depending on the first event's
> > > contents, this leads either to apparently normal behaviour, a crash or
> > > a freeze.
> > >
> > > While this behaviour of the firmware is not in accordance with the
> > > TCG Client EFI Specification, this happens on a Dell Precision 5510
> > > with the TPM enabled but hidden from the OS ("TPM On" disabled, state
> > > otherwise untouched). The EFI claims that the TPM is present and active
> > >  and supports the TCG 2.0 event log format.
> > >
> > > Fortunately, this can be worked around by simply checking the header
> > > of the first event and the event log header signature itself.
> > >
> > > Commit b4f1874c6216 ("tpm: check event log version before reading final
> > > events") addressed a similar issue also found on Dell models.
> > >
> > > Fixes: 6b0326190205 ("efi: Attempt to get the TCG2 event log in the boot stub")
> > > Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1165773
> > > Signed-off-by: Fabian Vogt <fvogt@suse.de>
> > > ---
> > >  include/linux/tpm_eventlog.h | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> > > index 4f8c90c93c29..b913faeedcb5 100644
> > > --- a/include/linux/tpm_eventlog.h
> > > +++ b/include/linux/tpm_eventlog.h
> > > @@ -81,6 +81,8 @@ struct tcg_efi_specid_event_algs {
> > >         u16 digest_size;
> > >  } __packed;
> > >
> > > +#define TCG_SPECID_SIG "Spec ID Event03"
> > > +
> > >  struct tcg_efi_specid_event_head {
> > >         u8 signature[16];
> > >         u32 platform_class;
> > > @@ -171,6 +173,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > >         int i;
> > >         int j;
> > >         u32 count, event_type;
> > > +       const u8 zero_digest[sizeof(event_header->digest)] = {0};
> > >
> > >         marker = event;
> > >         marker_start = marker;
> > > @@ -198,10 +201,19 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
> > >         count = READ_ONCE(event->count);
> > >         event_type = READ_ONCE(event->event_type);
> > >
> > > +       /* Verify that it's the log header */
> > > +       if (READ_ONCE(event_header->pcr_idx) != 0 ||
> > > +           READ_ONCE(event_header->event_type) != NO_ACTION ||
> > 
> > Is the READ_ONCE() necessary here?
> 
> I'm actually not sure about that. What's confusing me is that both event and
> event_header are pointers returned from EFI calls, but only event is passed
> through TPM_MEMREMAP if do_mapping is true. event_header is directly
> dereferenced without any mapping in any case. I assume it is an unwritten
> precondition that event_header is a pointer to mapped memory already? In that
> case READ_ONCE might be unnecessary indeed.

Nevermind, I just missed      VVVVVVVVV
@do_mapping:   Whether or not the event needs to be mapped

Will send V2 without READ_ONCE if the rest of the patch is fine.

> > > +           memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
> > > +               size = 0;
> > > +               goto out;
> > > +       }
> > > +
> > >         efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
> > >
> > >         /* Check if event is malformed. */
> > > -       if (count > efispecid->num_algs) {
> > > +       if (memcmp(efispecid->signature, TCG_SPECID_SIG,
> > > +                  sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
> > 
> > So is it guaranteed that every well formed event starts with TCG_SPECID_SIG?
> 
> I assume you mean "event log header" here.
> This is defined by the TCG EFI Protocol Spec in 5.3 Event Log Header:
> 
> A parser may read the first event [...]. The fields of the event log header are
> defined to be PCRIndex of 0, EventType of EV_NO_ACTION, Digest of 20 bytes of
> 0, and Event content defined as TCG_EfiSpecIDEventStruct. This first event is
> the event log header.
> 
> Table 3 then says about the first 16 bytes, the signature field:
> 
> The null terminated ASCII string “Spec ID Event03”.
> SHALL be set to {0x53, 0x70, 0x65, 0x63, 0x20, 0x49, 0x44, 0x20, 0x45, 0x76,
> 0x65, 0x6e, 0x74, 0x30, 0x33, 0x00}.
> 
> It references the TCG PC Client Specific TIS, where it says about Table 5:
> 
> The 16 bytes Signature for the TCG_EfiSpecIdEvent as defined in this
> specification is the NUL-terminated ASCII string “Spec ID Event03”. Based on
> this string an evaluator can determine that this log is formatted as crypto
> agile log and that the TCG_EfiSpecIdEvent contains information about
> recorded digests.
> 
> In the case that the event header indicates that it is the log header, it is
> still possible that this header is in a format which is not compatible with
> struct tcg_efi_specid_event_head. Verification of this signature makes sure
> that it is. The way I read the PC Client Specific TIS, only for this specific
> string it is guaranteed that it contains the desired information.
> 
> > >                 size = 0;
> > >                 goto out;
> > >         }
> > > --
> > > 2.25.1


