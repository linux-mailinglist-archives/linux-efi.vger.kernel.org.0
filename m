Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA329D7C7
	for <lists+linux-efi@lfdr.de>; Wed, 28 Oct 2020 23:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbgJ1W0z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 28 Oct 2020 18:26:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54178 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733112AbgJ1W0v (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 28 Oct 2020 18:26:51 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8D9F420B4907;
        Wed, 28 Oct 2020 09:30:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D9F420B4907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603902611;
        bh=0yTGgN/EY5AaVArBqci9i/YzNbbtn+Po5WFE/mNjXAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfKx1FJYPXmm2qCo5YexXOre5VXTY2p9ERBHX0pKj3W7LhstT0Pjy9+WB4twzHlFq
         ct95kXusmJNtT/TCA2SElN/cx7c1fumHnmmopqdltIMSZK2fhaDQ2l28KoRXbOR5ZC
         REeGIP7xzVM5IuwTkBfzC1/eR6H7lWAS6MF5Fbaw=
Date:   Wed, 28 Oct 2020 11:30:02 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] tpm: efi: Don't create binary_bios_measurements file for
 an empty log
Message-ID: <20201028163002.GA5150@sequoia>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20201028154102.9595-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201028154102.9595-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2020-10-28 10:41:02, Tyler Hicks wrote:
> Mimic the pre-existing ACPI and Device Tree event log behavior by not
> creating the binary_bios_measurements file when the EFI TPM event log is
> empty.
> 
> This fixes the following NULL pointer dereference that can occur when
> reading /sys/kernel/security/tpm0/binary_bios_measurements after the
> kernel received an empty event log from the firmware:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000002c
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 3932 Comm: fwupdtpmevlog Not tainted 5.9.0-00003-g629990edad62 #17
>  Hardware name: LENOVO 20LCS03L00/20LCS03L00, BIOS N27ET38W (1.24 ) 11/28/2019
>  RIP: 0010:tpm2_bios_measurements_start+0x3a/0x550
>  Code: 54 53 48 83 ec 68 48 8b 57 70 48 8b 1e 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 48 8b 82 c0 06 00 00 48 8b 8a c8 06 00 00 <44> 8b 60 1c 48 89 4d a0 4c 89 e2 49 83 c4 20 48 83 fb 00 75 2a 49
>  RSP: 0018:ffffa9c901203db0 EFLAGS: 00010246
>  RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000010
>  RDX: ffff8ba1eb99c000 RSI: ffff8ba1e4ce8280 RDI: ffff8ba1e4ce8258
>  RBP: ffffa9c901203e40 R08: ffffa9c901203dd8 R09: ffff8ba1ec443300
>  R10: ffffa9c901203e50 R11: 0000000000000000 R12: ffff8ba1e4ce8280
>  R13: ffffa9c901203ef0 R14: ffffa9c901203ef0 R15: ffff8ba1e4ce8258
>  FS:  00007f6595460880(0000) GS:ffff8ba1ef880000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000002c CR3: 00000007d8d18003 CR4: 00000000003706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   ? __kmalloc_node+0x113/0x320
>   ? kvmalloc_node+0x31/0x80
>   seq_read+0x94/0x420
>   vfs_read+0xa7/0x190
>   ksys_read+0xa7/0xe0
>   __x64_sys_read+0x1a/0x20
>   do_syscall_64+0x37/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> In this situation, the bios_event_log pointer in the tpm_bios_log struct
> was not NULL but was equal to the ZERO_SIZE_PTR (0x10) value. This was
> due to the following kmemdup() in tpm_read_log_efi():
> 
> int tpm_read_log_efi(struct tpm_chip *chip)
> {
> ...
> 	/* malloc EventLog space */
> 	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
> 	if (!log->bios_event_log) {
> 		ret = -ENOMEM;
> 		goto out;
> 	}
> ...
> }
> 
> When log_size is zero, due to an empty event log from firmware,
> ZERO_SIZE_PTR is returned from kmemdup(). Upon a read of the
> binary_bios_measurements file, the tpm2_bios_measurements_start()
> function does not perform a ZERO_OR_NULL_PTR() check on the
> bios_event_log pointer before dereferencing it.
> 
> Rather than add a ZERO_OR_NULL_PTR() check in functions that make use of
> the bios_event_log pointer, simply avoid creating the
> binary_bios_measurements_file as is done in other event log retrieval
> backends.
> 
> Explicitly ignore all of the events in the final event log when the main
> event log is empty. The list of events in the final event log cannot be
> accurately parsed without referring to the first event in the main event
> log (the event log header) so the final event log is useless in such a
> situation.
> 
> Fixes: 58cc1e4faf10 ("tpm: parse TPM event logs based on EFI table")
> Link: https://lore.kernel.org/linux-integrity/E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com/
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Thiébaud Weksteen <tweek@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

While I was never able to get my firmware to provide me an empty event
log, I reproduced this issue locally and verified the fix by forcing the EFI
stub to create an empty event log like so:

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 7acbac16eae0..a9b9478cff14 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -85,7 +85,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	/*
 	 * We populate the EFI table even if the logs are empty.
 	 */
-	if (!log_last_entry) {
+	if (true) {
 		log_size = 0;
 	} else {
 		last_entry_addr = (unsigned long) log_last_entry;

With that EFI stub change, I was able to verify that this crash happens
with or without commit 7f3d176f5f7e ("tpm: Require that all digests are
present in TCG_PCR_EVENT2 structures"). So, there's still the question
of why commit 7f3d176f5f7e uncovered this crash?

My theory, which I personally cannot prove since my Thinkpad's firmware
isn't acting the same as Kai's, Kenneth's, or Mimi's, is that some
EFI firmware is providing an empty main event log and a populated final
event log.

If this is true, prior to commit 7f3d176f5f7e, the EFI stub's
efi_retrieve_tpm2_eventlog() function would follow suite and provide the
same empty main event log and populated final event log to the kernel.

After commit 7f3d176f5f7e and when the main event log is empty, the
while loop below would start returning 0 because log_location is not a
valid event log header. It would either be zeroes or otherwise
junk/unexpected data (I'm not sure). The point is that final_events_size
is not incremented and the final event log is (rightfully, IMO) treated
as being empty after commit 7f3d176f5f7e.

void efi_retrieve_tpm2_eventlog(void)
{
...
	/*
	 * Figure out whether any events have already been logged to the
	 * final events structure, and if so how much space they take up
	 */
	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
	if (final_events_table && final_events_table->nr_events) {
		struct tcg_pcr_event2_head *header;
		int offset;
		void *data;
		int event_size;
		int i = final_events_table->nr_events;

		data = (void *)final_events_table;
		offset = sizeof(final_events_table->version) +
			sizeof(final_events_table->nr_events);

		while (i > 0) {
			header = data + offset + final_events_size;
			event_size = __calc_tpm2_event_size(header,
						   (void *)(long)log_location,
						   false);
			final_events_size += event_size;
			i--;
		}
	}
...
	log_tbl->final_events_preboot_size = final_events_size;
...
}

Now we'll move to tpm_read_log_efi() to see why it matters whether or
not final_events_size is zero:

/* read binary bios log from EFI configuration table */
int tpm_read_log_efi(struct tpm_chip *chip)
{
...
	efi_tpm_final_log_size -= log_tbl->final_events_preboot_size;

	tmp = krealloc(log->bios_event_log,
		       log_size + efi_tpm_final_log_size,
		       GFP_KERNEL);
	if (!tmp) {
		kfree(log->bios_event_log);
		ret = -ENOMEM;
		goto out;
	}

	log->bios_event_log = tmp;

	/*
	 * Copy any of the final events log that didn't also end up in the
	 * main log. Events can be logged in both if events are generated
	 * between GetEventLog() and ExitBootServices().
	 */
	memcpy((void *)log->bios_event_log + log_size,
	       final_tbl->events + log_tbl->final_events_preboot_size,
	       efi_tpm_final_log_size);
	log->bios_event_log_end = log->bios_event_log +
		log_size + efi_tpm_final_log_size;
...
}

There's nothing in tpm_read_log_efi(), prior to the patch I just
proposed, that prevents the final event log from being copied into an
otherwise empty main event log. In that situation, log->bios_event_log
is allocated (remember, it was not initially allocated because log_size
was 0) and the NULL pointer dereference crash upon reading the
binary_bios_measurements file would not happen.

The problem is that the resulting event log is not usable because
there's no event log header. __calc_tpm2_event_size() was too lax, prior
to commit 7f3d176f5f7e, to notice that the event log header was not
actually an event log header and, instead, was a regular event from the
final event log.

So, we need help from Kai, Kenneth, or Mimi to verify my assumption that
their firmware is providing an empty main event log and a populated
final event log. If that assumption is correct, then we could either:

A) Be alright with my proposed patch that bails out of
   tpm_read_log_efi() when the main event log is empty. The crash would
   be fixed and the binary_bios_measurements file simply would not
   exist.

or

B) Write an additional, separate patch for the EFI stub that ignores the
   final event log when the main event log is empty. Perhaps something
   like this (untested):

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index 7acbac16eae0..ad8f9ecf6dc2 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -127,7 +127,7 @@ void efi_retrieve_tpm2_eventlog(void)
 	 * Figure out whether any events have already been logged to the
 	 * final events structure, and if so how much space they take up
 	 */
-	if (version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
+	if (log_size && version == EFI_TCG2_EVENT_LOG_FORMAT_TCG_2)
 		final_events_table = get_efi_config_table(LINUX_EFI_TPM_FINAL_LOG_GUID);
 	if (final_events_table && final_events_table->nr_events) {
 		struct tcg_pcr_event2_head *header;

Tyler
